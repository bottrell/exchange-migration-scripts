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
### Purpose
- To generate a dynamic dashboard which shows the current migration progress. Pulls log data from the Quest drive which is only generated after CPUU success.
### Prerequisites 
- Must have access to the CPUU logs drive (should be \\usd1\logfiles$\Quest for this project)
- Must exist in a folder with an appropriately formatted workstations.csv file
### Usage
`.\Get-CPUU-logs.ps1 <workstations.csv>`

Example: `.\Get-cpuu-logs.ps1 1124workstations.csv`

Output: **************************
        Machine Name: MEM-LABLIB02PC
        Migration Status: Not started
        Migration Completed: False
        **************************
        Machine Name: MEM-CENTAPL08PC
        Migration Status: Completed
        Migration Completed: True
        ************************** 

## check-userdomain.ps1
### Purpose
- Essentially the same as running "whoami" on the targetted machine to quickly find out which domain the user is logged-in to 
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on
- User must be logged into the machine

### Usage
`.\check-userdomain.ps1 <machinename>`

Example: `.\check-userdomain.ps1 lt-csc15`

Output: `User jbottrell is in domain CAMC`

## check-userdomain.bat
### Purpose
- Another way to run "whoami" remotely on the targeted machine to find out which domain the user is logged-in to
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on
- User must be logged into the machine

Example: `.\check-userdomain.bat lt-csc15`
Output: `UserName: icamc\jbottrell`

## prompt-restart.ps1 (WIP)
### Prerequisites 
- Machines must be connected to the network (either vpn or on-site)
- Machine must be turned on

Example: 
Output: 
