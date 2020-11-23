param (
    [string]$filename
)
$ErrorActionPreference= 'silentlycontinue'

##----------------Functions-------------------##
## filename must be a valid csv file in the current directory
function Read-Machine-Names-From-CSV () {
    $imported = Import-Csv $filename
    $machines = $imported.ComputerName

    return $machines
}

function Initialize-Data-Dict ($machinenameslist) {
    #Iterate through machine names like the following:
    <# {
        Machine Name: {
                        "TextFiles" : @(),
                        "CSVFile" : FALSE
                      }
        }
    #>
    $finaldict = @{}
    foreach ($machine in $machinenameslist) {
        #only populate entries that aren't already in the dictionary
        if ($finaldict[$machine] -eq $null) {

            $finaldict[$machine] = @{}

            $finaldict[$machine]["TextFiles"] = @()

            $finaldict[$machine]["CsvFile"] = $false
        }
    }

    return $finaldict
}

function Populate-Data-Dict ($emptydict) {
    #Grab the current files from the share
    $files = Get-ChildItem -Path "\\usd1.i.camc.org\logfiles$\Quest\"
    $filenames = $files | Select Name

    #Because I'm not sure if Powershell used pass by reference or Pass by value
    $updateddict = $emptydict

    #iterate through each file, splice out the name, and update the dictionary accordingly
    foreach ($file in $filenames) {
        #Write-Host $file.Name
        $splitname = Split-File-Names $file.Name
       
        #check that the machine name exists in the dictionary
        if ($updateddict[$splitname] -ne $null) {

            #if it's a text file, add it to the "Textfiles" key 
            if ($file.Name -like "*.log") {
                $updateddict[$splitname]["TextFiles"] += $file.Name
               # Write-Host $updateddict[$splitname]["TextFiles"]
            }
            #if it's a CSV file, change "CSV" key to true
            if ($file.Name -like "*.csv") {
                $updateddict[$splitname]["CsvFile"] = $true
                #Write-Host $updateddict[$splitname]["CsvFile"]
            }
        }
    }

    return $updateddict
}

function Split-File-Names($fqn) {
    #if there is a v2, it is the 3rd index, otherwise it is the 2nd index
    $splitname = $fqn -split "_"
    if ($fqn -like "*v2*") {
        $splitname = $splitname[2]
    } elseif ($fqn -like "*CCU*") {
        $splitname = $splitname[2]
    } else {
        $splitname = $splitname[1]
    }
    return $splitname
}

function Print-Machine-Status($dict) {
    foreach ($key in $dict.Keys) {
        $migrationstatus = $new["$key"]["csvfile"]
        $logs = $new["$key"]["TextFiles"]
        if ($logs.count -eq 0) {
            $logstatus = "Not started"
        } else {
            $logstatus = "In Progress"
        }
        if ($migrationstatus -eq $true) {
            $logstatus = "Completed"
        }
        Write-Host "*************"
        Write-Host "Machine Name: $key"
        Write-Host "Migration Status: " -NoNewLine
        if ($logstatus -eq "Not started") {
            Write-Host $logstatus -ForegroundColor Black -BackgroundColor Red
        } elseif ($logstatus -eq "In Progress") {
            Write-Host $logstatus -ForegroundColor Black -BackgroundColor Yellow
        } elseif ($logstatus -eq "Completed") {
            Write-Host $logstatus -ForegroundColor Black -BackgroundColor Green
        }
        Write-Host "Migration Completed: $migrationstatus"
        Write-Host "*************" -NoNewline
        Start-Sleep -Seconds 1
    }
}

##--------------------Main--------------------##
$x = 0

#Essentially want the program to continue running until I command it to stop
while ($x -ne 1) {

    #Probably not the most efficient way of handling this, but doing it for ease of use
    $machinenames = Read-Machine-Names-From-CSV
    $dict = Initialize-Data-Dict $machinenames
    $new = Populate-Data-Dict $dict
    Print-Machine-Status $dict

    #Don't run through the loop again for 10 seconds
    Start-Sleep -Seconds 1
}