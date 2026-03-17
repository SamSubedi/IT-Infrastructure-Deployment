# 🖥️ IT Infrastructure Deployment

> A comprehensive collection of real-world IT infrastructure deployment projects covering on-premises setup, identity management, email services, and network security. All automation scripts are written in **PowerShell**.

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Windows Server](https://img.shields.io/badge/Windows_Server-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Microsoft Azure](https://img.shields.io/badge/Microsoft_Azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![Active Directory](https://img.shields.io/badge/Active_Directory-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Exchange Server](https://img.shields.io/badge/Exchange_Server-0078D4?style=for-the-badge&logo=microsoft-exchange&logoColor=white)
![SonicWall](https://img.shields.io/badge/SonicWall-FF6600?style=for-the-badge&logo=sonicwall&logoColor=white)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Repository Structure](#-repository-structure)
- [Projects](#-projects)
  - [01 · On-Prem IT Infrastructure](#01--on-prem-it-infrastructure)
  - [02 · Active Directory & Azure AD Connect](#02--active-directory--azure-ad-connect-project)
  - [03 · Exchange Server Deployment Manual (PDF)](#03--exchange-server-deployment-and-configuration-manual-pdf)
  - [04 · Exchange Server 2019 Production Deployment Script](#04--exchange-server-2019-production-deployment-script)
  - [05 · Next-Generation Firewall Project](#05--next-generation-firewall-project)
  - [06 · SonicWall Firewall](#06--sonicwall-firewall)
- [Technologies Used](#-technologies-used)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [Author](#-author)

---

## 🔍 Overview

This repository documents and automates the deployment of a full enterprise IT infrastructure stack — from core on-premises server setup and hybrid identity through to email services and perimeter network security. Each project folder is self-contained with its own detailed README, configuration guides, scripts, and supporting documentation.

The projects collectively form a complete enterprise environment covering:

- **Infrastructure Foundation** — On-premises server and network setup
- **Identity Management** — Active Directory + Azure AD hybrid synchronisation
- **Email Services** — Exchange Server 2019 deployment (manual + automated)
- **Network Security** — Next-Generation Firewall and SonicWall perimeter defence

---

## 🗂️ Repository Structure

```
IT-Infrastructure-Deployment/
│
├── 01. On Prem IT Infrastructure/
│   ├── README.md
│   ├── Network Diagrams/
│   ├── Server Configuration/
│   └── ...
│
├── 02. Active-Directory-and-Azure-AD-Connect-Project/
│   ├── README.md
│   ├── AD-Setup-Scripts/
│   ├── Azure-AD-Connect-Config/
│   └── ...
│
├── 03. Exchange-Server-Deployment-and-Configuration-Manual-PDF/
│   ├── README.md
│   ├── Exchange-Deployment-Manual.pdf
│   └── ...
│
├── 04. Exchange-Server-2019-Production-Deployment-Script/
│   ├── README.md
│   ├── Deploy-ExchangeServer2019.ps1
│   ├── Post-Install-Config.ps1
│   └── ...
│
├── 05. Next-Generation-Firewall-Project/
│   ├── README.md
│   ├── Firewall-Policy-Config/
│   ├── Network-Diagrams/
│   └── ...
│
├── 06. SonicWall-Firewall/
│   ├── README.md
│   ├── SonicWall-Config-Export/
│   ├── VPN-Setup/
│   └── ...
│
└── README.md                  ← You are here
```

---

## 📁 Projects

---

### 01 · On-Prem IT Infrastructure

📂 **[View Project →](./01.%20On%20Prem%20IT%20Infrastructure/)**

#### Overview

This project establishes the foundational on-premises IT infrastructure for an enterprise environment. It covers the physical and virtual server layout, network topology design, IP addressing schemes, and the baseline Windows Server configuration required before any higher-level services (such as Active Directory or Exchange) are deployed.

#### What's Covered

- Physical/virtual server rack design and planning
- Network topology and VLAN segmentation
- IP address management (IPAM) and subnetting strategy
- Windows Server roles and features baseline setup
- DNS and DHCP configuration
- Storage and backup infrastructure planning
- Documentation of hardware inventory and licensing

#### Key Technologies

| Component | Technology |
|-----------|-----------|
| Operating System | Windows Server 2019 / 2022 |
| Virtualisation | Hyper-V / VMware |
| Networking | VLANs, Subnetting, DNS, DHCP |
| Scripting | PowerShell |

---

### 02 · Active Directory & Azure AD Connect Project

📂 **[View Project →](./02.%20Active-Directory-and-Azure-AD-Connect-Project/)**

#### Overview

This project covers the complete deployment and configuration of **Active Directory Domain Services (AD DS)** alongside **Azure AD Connect** to create a hybrid identity environment. It bridges the on-premises Active Directory with Microsoft Azure Active Directory (Entra ID), enabling Single Sign-On (SSO) and seamless cloud service access for users.

#### What's Covered

- Active Directory domain installation and promotion
- Organisational Unit (OU) structure design
- Group Policy Object (GPO) creation and management
- User and group provisioning via PowerShell
- Azure AD Connect installation and configuration
- Password Hash Synchronisation (PHS) / Pass-Through Authentication (PTA) setup
- Synchronisation rules and filtering
- Hybrid identity troubleshooting and validation

#### Architecture

```
On-Premises AD (Windows Server)
         │
         │  Azure AD Connect Sync
         ▼
Microsoft Azure AD (Entra ID)
         │
         ▼
  Microsoft 365 / Azure Services
```

#### Key Technologies

| Component | Technology |
|-----------|-----------|
| Identity Provider | Active Directory Domain Services |
| Cloud Identity | Azure Active Directory (Entra ID) |
| Sync Tool | Azure AD Connect |
| Scripting | PowerShell |
| Authentication | PHS / PTA / SSO |

---

### 03 · Exchange Server Deployment and Configuration Manual (PDF)

📂 **[View Project →](./03.%20Exchange-Server-Deployment-and-Configuration-Manual-PDF/)**

#### Overview

This project provides a **comprehensive step-by-step PDF manual** for deploying and configuring Microsoft Exchange Server in an enterprise environment. The manual is intended as a reference document for IT administrators performing manual or guided installations, and covers everything from prerequisites through to post-installation configuration and testing.

#### What's Covered

- Hardware and software prerequisites checklist
- Exchange Server pre-requisite installation (Windows roles, .NET, VC++ Redistributables)
- Exchange Server installation walkthrough (GUI-based)
- DNS record configuration (MX, Autodiscover, SPF, DKIM, DMARC)
- Send and Receive Connector configuration
- Mailbox database creation and management
- Client Access configuration (Outlook, OWA, ActiveSync)
- Certificate management (internal CA and public SSL)
- Basic anti-spam and hygiene configuration
- Post-deployment health checks

#### Document Format

This project is delivered as a **PDF manual** — ideal for:
- Step-by-step guided deployments
- Internal IT documentation / knowledge base
- Training and onboarding new IT staff
- Audit and compliance documentation

---

### 04 · Exchange Server 2019 Production Deployment Script

📂 **[View Project →](./04.%20Exchange-Server-2019-Production-Deployment-Script/)**

#### Overview

This project automates the complete production deployment of **Exchange Server 2019** using PowerShell. Where Project 03 is a manual reference guide, this project provides the automation layer — scripts that handle prerequisite installation, Exchange setup, and post-installation configuration with minimal manual intervention.

#### What's Covered

- Automated Windows prerequisite role/feature installation
- .NET Framework and Visual C++ Redistributable silent installation
- Exchange Server 2019 unattended installation
- Mailbox database creation and configuration
- Virtual Directory (OWA, ECP, OAB, EWS, MAPI, ActiveSync) URL setup
- Send/Receive Connector creation
- SSL Certificate request and binding automation
- Exchange health check and validation post-deployment
- Logging and error handling throughout

#### Script Structure

```powershell
Deploy-ExchangeServer2019.ps1   # Main deployment orchestrator
Install-Prerequisites.ps1       # Windows roles, .NET, VC++ Redist
Configure-Exchange.ps1          # Post-install configuration
Set-VirtualDirectories.ps1      # URL/Virtual Directory config
New-MailboxDatabase.ps1         # Database creation and mount
Validate-Deployment.ps1         # Health checks and test send/receive
```

#### Usage

```powershell
# Run as Administrator on the Exchange Server
.\Deploy-ExchangeServer2019.ps1 -OrganizationName "Contoso" -DomainName "contoso.com"
```

> ⚠️ **Important:** Always test in a lab/staging environment before running in production. Review all script parameters before execution.

---

### 05 · Next-Generation Firewall Project

📂 **[View Project →](./05.%20Next-Generation-Firewall-Project/)**

#### Overview

This project documents the design, deployment, and configuration of a **Next-Generation Firewall (NGFW)** to secure the enterprise network perimeter. NGFWs go beyond traditional stateful inspection by providing application-layer filtering, intrusion prevention (IPS/IDS), SSL inspection, and advanced threat protection.

#### What's Covered

- Network perimeter design and DMZ architecture
- NGFW installation and initial setup
- Security zone and interface configuration
- Firewall policy and rule creation (Zero Trust principles)
- Application-layer inspection and filtering
- Intrusion Prevention System (IPS) / Intrusion Detection System (IDS) tuning
- SSL/TLS deep packet inspection configuration
- URL filtering and content control policies
- Threat intelligence and logging integration
- VPN configuration (Site-to-Site and Remote Access)
- High Availability (HA) failover setup

#### Network Architecture

```
[ Internet ]
     │
     ▼
[ NGFW — Perimeter ]
  ┌───────────────┐
  │   Firewall    │
  │   Policies    │
  └───┬───────┬───┘
      │       │
   [DMZ]  [Internal LAN]
      │       │
  [Web/    [AD, Exchange,
   Mail]    File Servers]
```

#### Key Technologies

| Component | Technology |
|-----------|-----------|
| Firewall Type | Next-Generation Firewall (NGFW) |
| Capabilities | IPS/IDS, App Control, SSL Inspection, URL Filter |
| VPN | Site-to-Site IPSec, SSL VPN |
| Architecture | DMZ, Zone-Based Security |

---

### 06 · SonicWall Firewall

📂 **[View Project →](./06.%20SonicWall-Firewall/)**

#### Overview

This project covers the deployment and configuration of a **SonicWall firewall** appliance for small-to-medium enterprise network security. SonicWall is a widely used hardware firewall solution offering deep packet inspection, VPN services, content filtering, and centralised management.

#### What's Covered

- SonicWall hardware initial setup and firmware update
- Interface and zone configuration (LAN, WAN, DMZ, VPN)
- NAT policy configuration (1:1 NAT, PAT / Port Forwarding)
- Access rules and security policies
- Site-to-Site IPSec VPN tunnel configuration
- SSL VPN / NetExtender remote access VPN setup
- Deep Packet Inspection (DPI) and DPI-SSL configuration
- Content filtering and App Control Advanced policies
- Geo-IP filtering and Botnet protection
- DHCP server setup on SonicWall interfaces
- High Availability (HA) Active/Standby pair configuration
- SonicWall logging and SIEM integration
- Backup, export, and restore of SonicWall configuration

#### SonicWall Interface Zone Layout

```
WAN (X1) ──── [ Internet / ISP ]
LAN (X0) ──── [ Internal Corporate Network ]
DMZ (X2) ──── [ Public-facing Servers ]
VPN  ────────── [ Remote Sites / Users ]
```

#### Key Technologies

| Component | Technology |
|-----------|-----------|
| Appliance | SonicWall TZ / NSA / NSv Series |
| VPN | IPSec Site-to-Site, SSL VPN (NetExtender) |
| Threat Protection | DPI, App Control, Geo-IP, Botnet Filter |
| Management | SonicOS Web UI / SonicWall NSM |
| HA | Active/Standby Failover |

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Windows Server 2019/2022** | Base OS for all server roles |
| **Active Directory Domain Services** | On-premises identity and authentication |
| **Azure Active Directory (Entra ID)** | Cloud identity and SSO |
| **Azure AD Connect** | Hybrid identity synchronisation |
| **Microsoft Exchange Server 2019** | On-premises email services |
| **PowerShell** | Automation and scripting throughout |
| **Next-Generation Firewall** | Advanced perimeter threat protection |
| **SonicWall** | Hardware firewall and VPN gateway |
| **DNS / DHCP** | Core network services |
| **Hyper-V / VMware** | Virtualisation platform |

---

## ✅ Prerequisites

Before working with any project in this repository, ensure you have:

- **Windows Server 2019 or 2022** (physical or virtual)
- **PowerShell 5.1+** (or PowerShell 7+ for cross-platform scripts)
- **Domain Admin / Enterprise Admin** privileges where required
- **Microsoft 365 / Azure subscription** (for Azure AD Connect projects)
- **Valid SSL certificates** (for Exchange Server virtual directories)
- **Appropriate hardware** or licensed virtual appliances (SonicWall, NGFW)
- Basic understanding of **Active Directory**, **DNS**, **TCP/IP networking**

> 💡 Each project folder contains its own detailed prerequisites section in its README.

---

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/SamSubedi/IT-Infrastructure-Deployment.git
   cd IT-Infrastructure-Deployment
   ```

2. **Navigate to the relevant project folder:**
   ```bash
   cd "01. On Prem IT Infrastructure"
   ```

3. **Read the project README** for specific setup instructions, prerequisites, and execution steps.

4. **For scripted deployments** (Projects 02 and 04), always:
   - Review scripts thoroughly before running
   - Test in a **lab or staging environment** first
   - Run PowerShell as **Administrator**
   - Check and update any configurable variables at the top of each script

---

## 👤 Author

**Sam Subedi**

[![GitHub](https://img.shields.io/badge/GitHub-SamSubedi-181717?style=flat&logo=github)](https://github.com/SamSubedi)

---

> 📌 *Each project folder contains its own detailed README with step-by-step instructions, screenshots, configuration details, and troubleshooting notes. Use the links above to navigate directly to each project.*
