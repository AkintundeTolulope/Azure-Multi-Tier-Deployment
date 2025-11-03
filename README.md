Azure Multi-Tier Deployment Project

This project demonstrates the deployment of a secure multi-tier architecture on Microsoft Azure using Azure CLI and GitHub for version control. It includes the creation of a Virtual Network (VNet) with three subnets (Web, App, and Database tiers), Network Security Groups (NSGs), and Virtual Machines (VMs) configured for controlled communication between tiers.

Architecture Design
VNet Name: myproject-vnet
Subnets: sunlight
Web Subnet (10.0.0.0/24)
App Subnet (10.0.1.0/24)
DB Subnet (10.0.2.0/24)
Virtual Machines:
webVM – Ubuntu 22.04
appVM – Ubuntu 22.04
dbVM – Ubuntu 22.04
Region: West Europe 
Resource Group: myproject-rg

Network Security Configuration
Web NSG: Allows HTTP (80) and SSH (22)
App NSG: Allows traffic from Web subnet (10.0.0.0/24) on port 80
DB NSG: Allows traffic from App subnet (10.0.1.0/24) on port 3306

Automation Script
All deployment steps were automated using a Bash script that provisions:
Resource Group
Virtual Network and Subnets
Network Security Groups
Virtual Machines
Connectivity tests between tiers
Script file:
azure-multitier-deployment.sh

Connectivity Verification
Ping and curl tests were conducted to verify connectivity:
Web ➜ App ✅
App ➜ DB ✅
Example test results:
20 packets transmitted, 20 received, 0% packet loss

Deliverables
Azure CLI Bash Deployment Script
NSG Configurations
Screenshots of:
VNet and Subnets
VM Creation
NSG Rules
Successful Connectivity Tests
Full Project Documentation (PDF or Word)

Challenges & Troubleshooting
Some VM sizes were unavailable in UK South region. To fix this, deployment was switched to west europe. Other challenges included NSG configuration and SSH connectivity, both resolved through step-by-step troubleshooting.

Author
Akintunde Tolulope
