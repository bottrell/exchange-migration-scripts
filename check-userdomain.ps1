param (
    [Parameter(Mandatory)]$machinename
)
$ErrorActionPreference = 'Stop'

<#--Query PC for currently logged in user and domain. If an error occurs, exist the script--#>
$fullresponse = Get-WmiObject Win32_ComputerSystem -ComputerName $machinename | Select-Object -ExpandProperty UserName
$split = $fullresponse.split('\')
$username = $split[1]
$domain = $split[0]

<#---------Pretty Output---------#>
Write-Host "User " -NoNewline
Write-Host $username -NoNewline -ForegroundColor black -Backgroundcolor White
Write-Host " is in domain " -NoNewLine
Write-Host "$domain`n"  -foregroundcolor black -Backgroundcolor White