####################################################################################################
# SCRIPT: Exchange 2019 Production-Ready Deployment
# DESCRIPTION:
#   - Fully automated Mailbox Role install for Windows Server 2016, 2019, 2022, 2025
#   - Checks AD & Schema readiness
#   - Configures TLS 1.2 / TLS 1.3 where supported
#   - Installs prerequisites, Visual C++ runtimes
#   - Downloads and installs Exchange 2019 CU15 silently
#   - Logs all steps for enterprise review
#   - Install path: E:\Exchange
####################################################################################################

#---------------------------------------
# GLOBAL VARIABLES
#---------------------------------------
$OSVersion = (Get-CimInstance Win32_OperatingSystem).Version
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$InstallPath = "E:\Exchange"
$DownloadFolder = "E:\Exchange\Downloads"
$LogFile = "$PSScriptRoot\$Date-ExchangeDeploy.log"

Start-Transcript -Path $LogFile -Append
Write-Host "Exchange 2019 Production Deployment Script - Started at $Date" -ForegroundColor Cyan

#---------------------------------------
# HELPER FUNCTIONS
#---------------------------------------

Function Ensure-DownloadFolder {
    if (!(Test-Path $DownloadFolder)) { New-Item -Path $DownloadFolder -ItemType Directory | Out-Null }
}

Function Check-DomainAndSchema {
    Write-Host "Checking if server is domain joined..." -ForegroundColor Cyan
    if (-not ([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain())) {
        Write-Host "Server is NOT domain-joined. Exchange cannot install." -ForegroundColor Red
        Stop-Transcript; exit
    }
    Write-Host "Server is domain-joined." -ForegroundColor Green

    Write-Host "Checking AD Schema for Exchange 2019 readiness..." -ForegroundColor Cyan
    $schemaVersion = (Get-ADObject (Get-ADRootDSE).schemaNamingContext -Property objectVersion).objectVersion
    if ($schemaVersion -lt 88) {
        Write-Host "AD Schema not updated for Exchange 2019. Run SchemaPrep first." -ForegroundColor Red
        Stop-Transcript; exit
    }
    Write-Host "AD Schema version OK." -ForegroundColor Green
}

Function Install-WindowsFeatures {
    Write-Host "Installing Windows Features required for Mailbox role..." -ForegroundColor Cyan
    $features = @(
        "RSAT-AD-PowerShell","ADLDS","NET-Framework-45-Features","RPC-over-HTTP-proxy",
        "RSAT-Clustering","RSAT-Clustering-CmdInterface","RSAT-Clustering-Mgmt","RSAT-Clustering-PowerShell",
        "Web-Mgmt-Console","WAS-Process-Model","Web-Asp-Net45","Web-Basic-Auth","Web-Client-Auth",
        "Web-Digest-Auth","Web-Dir-Browsing","Web-Http-Errors","Web-Http-Logging","Web-Http-Redirect",
        "Web-Http-Tracing","Web-ISAPI-Ext","Web-ISAPI-Filter","Web-Lgcy-Mgmt-Console","Web-Metabase",
        "Web-Mgmt-Service","Web-Net-Ext45","Web-Request-Monitor","Web-Server","Web-Stat-Compression",
        "Web-Static-Content","Web-Windows-Auth","Web-WMI","RSAT-ADDS"
    )
    Install-WindowsFeature -Name $features -IncludeManagementTools | Out-Null
    Write-Host "Windows Features installed." -ForegroundColor Green
}

Function Install-VCRuntime {
    Ensure-DownloadFolder
    $VCUrls = @(
        "https://aka.ms/vs/17/release/vc_redist.x64.exe",
        "https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c691ad05b/vcredist_x64.exe"
    )
    foreach ($url in $VCUrls) {
        $file = Join-Path $DownloadFolder (Split-Path $url -Leaf)
        if (!(Test-Path $file)) { Start-BitsTransfer -Source $url -Destination $file }
        Write-Host "Installing $file..." -ForegroundColor Cyan
        Start-Process -FilePath $file -ArgumentList "/quiet /norestart" -Wait
    }
    Write-Host "Visual C++ Runtimes installed." -ForegroundColor Green
}

Function Configure-Performance {
    Write-Host "Configuring performance settings..." -ForegroundColor Cyan
    # High Performance Power Plan
    $HighPerf = (powercfg -l | Where-Object {$_ -like "*High performance*"}).Split()[3]
    if ($HighPerf) { powercfg -setactive $HighPerf }
    # Pagefile = RAM + 10MB, max 32GB
    $RamMB = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1MB
    $PageSize = [Math]::Min([int]($RamMB + 10), 32778)
    Set-CimInstance -Query "Select * from Win32_ComputerSystem" -Property @{AutomaticManagedPagefile=$false}
    Set-CimInstance -Query "Select * from Win32_PageFileSetting" -Property @{InitialSize=$PageSize;MaximumSize=$PageSize} -ErrorAction SilentlyContinue
    Write-Host "Pagefile set to $PageSize MB." -ForegroundColor Green
}

Function Configure-TLS {
    Write-Host "Configuring TLS 1.2/1.3 and disabling legacy protocols..." -ForegroundColor Cyan
    $Protocols = @{"TLS 1.2"=1; "TLS 1.3"=0; "SSL 3.0"=0; "TLS 1.0"=0; "TLS 1.1"=0}
    # Enable TLS 1.3 only on 2022/2025
    if ($OSVersion -ge '10.0.20348') { $Protocols["TLS 1.3"]=1 }
    $NetPaths = @("HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319","HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319")
    foreach ($path in $NetPaths) {
        if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
        Set-ItemProperty -Path $path -Name "SystemDefaultTlsVersions" -Value 1 -Type DWord
        Set-ItemProperty -Path $path -Name "SchUseStrongCrypto" -Value 1 -Type DWord
    }
    foreach ($proto in $Protocols.Keys) {
        foreach ($type in @("Server","Client")) {
            $KeyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\$proto\$type"
            if (!(Test-Path $KeyPath)) { New-Item -Path $KeyPath -Force | Out-Null }
            Set-ItemProperty -Path $KeyPath -Name "Enabled" -Value $Protocols[$proto] -Type DWord
            Set-ItemProperty -Path $KeyPath -Name "DisabledByDefault" -Value (1 - $Protocols[$proto]) -Type DWord
        }
    }
    Write-Host "TLS configuration applied." -ForegroundColor Green
}

Function Download-Exchange {
    Ensure-DownloadFolder
    $ExchangeURL = "https://download.microsoft.com/download/0/2/C/02C6C2E7-9434-4F2B-B75D-AC958C00B2F8/Exchange2019-x64-cu15.iso"
    $ISOFile = Join-Path $DownloadFolder "Exchange2019-CU15.iso"
    if (!(Test-Path $ISOFile)) {
        Write-Host "Downloading Exchange 2019 CU15 ISO..." -ForegroundColor Cyan
        Start-BitsTransfer -Source $ExchangeURL -Destination $ISOFile
    }
    Write-Host "Exchange ISO ready at $ISOFile" -ForegroundColor Green
    return $ISOFile
}

Function Install-Exchange {
    param([string]$ISOPath)
    Write-Host "Mounting Exchange ISO..." -ForegroundColor Cyan
    $mount = Mount-DiskImage -ImagePath $ISOPath -PassThru
    Start-Sleep -Seconds 3
    $DriveLetter = ($mount | Get-Volume).DriveLetter + ":"
    $SetupPath = Join-Path $DriveLetter "Setup.exe"
    Write-Host "Installing Exchange 2019 Mailbox role silently..." -ForegroundColor Cyan
    & $SetupPath /Mode:Install /Roles:Mailbox /IAcceptExchangeServerLicenseTerms /TargetDir:$InstallPath /EnableErrorReporting:$false
    Write-Host "Exchange installation initiated. Logs in $InstallPath\Logging" -ForegroundColor Green
    Dismount-DiskImage -ImagePath $ISOPath
}

#---------------------------------------
# MAIN EXECUTION
#---------------------------------------

Write-Host "Starting production-ready deployment..." -ForegroundColor Cyan

# OS Check
$OSSupported = @('10.0.14393','10.0.17763','10.0.20348','10.0.26100') # 2016/2019/2022/2025
if (-not ($OSSupported | ForEach-Object { $OSVersion.StartsWith($_) } | Where-Object {$_})) {
    Write-Host "Unsupported OS version: $OSVersion" -ForegroundColor Red
    Stop-Transcript; exit
}

Check-DomainAndSchema
Install-WindowsFeatures
Install-VCRuntime
Configure-Performance
Configure-TLS
$ExchangeISO = Download-Exchange
Install-Exchange -ISOPath $ExchangeISO

Write-Host "Exchange 2019 Production Deployment Completed!" -ForegroundColor Cyan
Stop-Transcript
