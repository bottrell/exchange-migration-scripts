# ExchangeMigrationScripts
Migration scripts for Microsoft Exchange 2007 to 2016 migration for large enterprise client

Scripts are a mix of Powershell and bash scripts, however both should be able to be run from an elevated powershell prompt. I prefer to run the commands remotely, however I believe that they could be run remotely via a psexec session

## check-machinedomain.bat
### Purpose
- To check the domain of the specified machine
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on
### Usage
` .\check-machinedomain.bat <machinename>`

Example: `.\check-machinedomain.bat lt-csc15`

Output: `Domain:                    camc.hsi`

## Get-CPUU-logs.ps1
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on

Example:
Output: 

## check-userdomain.ps1
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on

Example:
Output: 

## check-userdomain.bat
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on

Example:
Output:

## prompt-restart.ps1 (WIP)
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on

Example: 
Output: 
