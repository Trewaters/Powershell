cd "C:\Users\Tre'\SkyDrive\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs"

# try these
Get-Process
Get-Service
Get-EventLog security -newest 100

# export to csv
Get-EventLog security -newest 100 | Export-Csv "C:\Users\Tre'\SkyDrive\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs\eventLog.csv"

# sortable, highly interactive pop out grid
Get-Process | Out-GridView

# open a file in windows notepad
Notepad eventLog.csv

# import
Import-Csv eventLog.csv

# get other similar commands
Get-Command -Verb *Out*
Get-Command -Noun *Grid*
Get-Command *convert*

# check for differences in 2 files
Get-Process | Export-Clixml reference.xml

Diff -referenceObject (Import-Clixml reference.xml) -DifferenceObject (Get-Process) -property Name

# output to HTML
Get-Service | convertTo-HTML | Out-File services.html
Get-Service | convertTo-Json | Out-File services.json

# get notepad and kill the notepad process
# confirm forces the system to prompt "are you sure?"
Get-Process Notepad | Stop-Process -confirm 
Get-Process Notepad | Stop-Process -whatif

Notepad

# read content into powershell
Get-EventLog -LogName Security -newest 5 | export-csv events.csv
Get-content .\text.txt
import-csv .\events.csv

# execution policy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

# Lab
Get-Service | export-csv services.csv | Out-File lab.txt