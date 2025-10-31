#!/bin/bash 
# Azure Multi-Tier Architecture Deployment 
# By Tolulope


# Variables
rg="myproject"
location="westeurope"
vnet="sunlight"
websubnet="websubnet"
appsubnet="appsubnet"
dbsubnet="dbsubnet"
webnsg="webNSG"
appnsg="appNSG"
DBnsg="dbNSG"
vmsize="Standard_B1s"

echo "starting deployment of Azure Multi-Tier Architecture"

# Create Resource Group
echo "Creating Resource Group"
az group create --name $rg --location $location

# Create Virtual Network and Subnets
echo "Creating Virtual Network and Subnets"
az network vnet create --resource-group $rg --name $vnet --address-prefix 10.0.0.0/16 --subnet-name $websubnet --subnet-prefix 10.0.1.0/24
az network vnet subnet create --resource-group $rg --vnet-name $vnet --name $appsubnet --address-prefix 10.0.2.0/24
az network vnet subnet create --resource-group $rg --vnet-name $vnet --name $dbsubnet --address-prefix 10.0.3.0/24

# Create NSGs
echo "Creating Network Security Groups"
az network nsg create --resource-group $rg --name $webnsg
az network nsg create --resource-group $rg --name $appnsg
az network nsg create --resource-group $rg  --name $dbnsg

# Create NSG Rules
echo "Configuring NSG Rules"
az network nsg rule create --resource-group $rg --nsg-name $webnsg --name AllowWebToApp --priority 100 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes 10.0.1.0/24 --destination-port-ranges 22 80
az network nsg rule create --resource-group $rg --nsg-name $appnsg --name AllowAppToDB --priority 100 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes 10.0.2.0/24 --destination-port-ranges 22-3306

# Create Virtual Machines
echo "Deploying Virtual Machines"
az vm create --resource-group $rg --name webvm --image Ubuntu2204 --vnet-name $vnet --subnet $websubnet --nsg $webnsg --size $vmsize --admin-username  overcomer --generate-ssh-keys
az vm create --resource-group $rg --name appvm --image Ubuntu2204 --vnet-name $vnet --subnet $appsubnet --nsg $appnsg --size $vmsize --admin-username overcomer --generate-ssh-keys
az vm create --resource-group $rg --name dbvm --image Ubuntu2204 --vnet-name $vnet --subnet $dbsubnet --nsg $dbnsg --size $vmsize --admin-username overcomer --generate-ssh-keys

# Output private IPs for verification
echo "Deployment complete....Listing private IPs"
az vm list-ip-address --resource-group $rg --output table 

