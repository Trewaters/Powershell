# See all columns in process
Get-Process | ConvertTo-HTML | Out-File "C:\Users\Tre'\Documents\Hunting\Coding Work Study\GitHub\Powershell\Month of Lunches\Labs\processes.html"

# Discovering object with Get-Member, aliased as `gm`
Get-process | Get-Member
Get-Process | gm

# Simple pipeline example
Get-Process |
Sort-Object VM -descending |
Out-File "C:\Users\Tre'\Documents\Hunting\Coding Work Study\GitHub\Powershell\Month of Lunches\Labs\procs.txt"

# Select-Ojbect
Get-Process |
Sort-Object VM -descending |
Select-Object Name,ID,VM 

# different looking outputs
Get-Process | Sort VM -descending | gm
Get-Process | Sort VM -descending | Select Name,ID,VM | gm

Get-Process | Gm | Gm

# Identify a cmdlet that produces a random number
Get-Random

# cmdlet that displays the current date and time
Get-Date
Get-Date | Get-Member

Get-Date | Select-Object DayOfWeek

#Identify a cmdlet that displays information about installed hotfixes on Windows systems.
Get-HotFix | gm

# display a list of installed hotfixes. Then extend the expression to sort the list by the installation date, and display only the installation date, the user who installed the hotfix, and the hotfix ID. Remember that the column headers shown in a command’s default output aren’t necessarily the real property names—you need to look up the real property names to be sure.
Get-Hotfix | Sort InstalledOn | Select-Object InstalledOn, InstalledBy, HotFixID, Description

# This time sort the results by the hotfix description, and include the description, the hotfix ID, and the installation date. Put the results into an HTML file.
Get-HotFix | 
Sort Description | 
Select Description, INstalledOn, INstalledBy, HotFixID, FixComments | 
ConvertTo-Html -Title "HotFixReport" | 
Out-File HotFixReport.htm

# Display a list of the 50 newest entries from the Security event log (you can use a different log, such as System or Application, if your Security log is empty). Sort the list with the oldest entries appearing first, and with entries made at the same time sorted by their index. Display the index, time, and source for each entry. Put this information into a text file (not an HTML file, but a plain-text file). You may be tempted to use Select-Object and its -first or -last parameters to achieve this; don’t. There’s a better way. Also, avoid using Get-WinEvent for now; a better cmdlet is available for this particular task.
Get-EventLog -LogName System -Newest 50 |
SOrt TimeGenerated,Index |
Select Index, TimeGenerated, Source |
Out-File elogs.txt

Get-EventLog -LogName System -Newest 1 | Select-Object EventID,TimeWritten,Message

Get-EventLog -list | sort Entries -Descending