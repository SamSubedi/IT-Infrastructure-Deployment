# IT Infrastructure Deployment

## Overview

This repository demonstrates the design and implementation of a **complete enterprise IT infrastructure environment**. The project covers essential infrastructure components including on-premises systems, identity management, email services, and network security.

Each module of the project is organized into separate folders with detailed documentation explaining the deployment process, configurations, and implementation steps.

This project highlights practical experience in **system administration, enterprise infrastructure deployment, and network security management**.

---

## Infrastructure Architecture

Below is a simplified architecture of the infrastructure environment implemented in this project.

```
                     Internet
                         |
                         |
                +----------------+
                |   Firewall     |
                | (SonicWall /   |
                |  NGFW)         |
                +--------+-------+
                         |
                    Internal LAN
                         |
        +----------------+----------------+
        |                                 |
+---------------+                 +---------------+
| Domain        |                 | Exchange      |
| Controller    |                 | Server 2019   |
| Active Dir.   |                 | Mail Services |
+-------+-------+                 +-------+-------+
        |                                 |
        |                                 |
+---------------+                 +---------------+
| Azure AD      |                 | User Devices  |
| Connect Sync  |                 | (Clients)     |
+---------------+                 +---------------+
```

---

## Project Modules

### 1. On-Prem IT Infrastructure

This module focuses on the deployment of a traditional **on-premises IT environment**, including server configuration, networking setup, and infrastructure planning.

### 2. Active Directory and Azure AD Connect Project

Implementation of **Active Directory Domain Services (AD DS)** and integration with **Azure AD Connect** to enable hybrid identity synchronization between on-premises and cloud environments.

### 3. Exchange Server Deployment and Configuration Manual

Detailed documentation for installing and configuring **Microsoft Exchange Server**, including mailbox setup, email routing, and administrative management.

### 4. Exchange Server 2019 Production Deployment Script

Automation scripts used for deploying **Exchange Server 2019** in a production-ready environment using PowerShell and best practices.

### 5. Next Generation Firewall Project

Configuration of a **Next Generation Firewall (NGFW)** including network security policies, traffic inspection, access control, and monitoring.

### 6. SonicWall Firewall

Deployment and configuration of a **SonicWall firewall** including NAT rules, firewall policies, VPN setup, and network protection mechanisms.

---

## Technologies Used

* Windows Server
* Active Directory Domain Services
* Azure AD Connect
* Microsoft Exchange Server 2019
* PowerShell Automation
* SonicWall Firewall
* Next Generation Firewall (NGFW)
* DNS
* DHCP
* Virtual Machines
* Enterprise Networking Concepts

---

## Repository Structure

```
IT-Infrastructure-Deployment
│
├── 01. On Prem IT Infrastructure
├── 02. Active-Directory-and-Azure-AD-Connect-Project
├── 03. Exchange-Server-Deployment-and-Configuration-Manual-PDF
├── 04. Exchange-Server-2019-Production-Deployment-Script
├── 05. Next-Generation-Firewall-Project
└── 06. SonicWall-Firewall
```

Each folder contains its own **detailed README file** explaining the configuration process and implementation steps.

---

## Skills Demonstrated

* Enterprise IT Infrastructure Deployment
* Active Directory Administration
* Hybrid Identity Integration
* Exchange Server Administration
* PowerShell Automation
* Firewall Configuration
* Network Security Implementation
* System Administration


## Purpose

This project was developed as a **technical portfolio project** to demonstrate practical skills in **enterprise infrastructure deployment, identity management, messaging systems, and network security**.
