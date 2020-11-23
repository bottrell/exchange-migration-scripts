#Combines every csv file for a specific date into one single file. Mandatory parameters are date (e.g. 20201118) and a boolean representing "Users" (0) or "Workstations" (1)
#CAMC domain-exchange migration 11/18/2020
param (
    [Parameter(Mandatory)]$date,
    [Parameter(Mandatory)]$usersorworkstations
)

if ($usersorworkstations -eq 0) {
    $type = "users"
} else {
    $type = "workstations"
}

#Output file name will be in the format "20201118workstations-exported.csv"
$outputfilename = "$date$type-exported.csv"
New-Item $outputfilename

$files = Get-ChildItem "." -Filter *.csv

#Iterate through the file names and if they include both the date and type
foreach ($file in $files) {

    if (($file -like "*$date*") -and ($file -like "*$type*"))  {
        
        #Import the data from the input file and append to the output file
        $imported = Import-Csv $file | Select-Object -Skip 1
        $imported | Export-Csv -append $outputfilename

    }

}