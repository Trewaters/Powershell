# See all columns in process
Get-Process | ConvertTo-HTML | Out-File "C:\Users\Tre'\Documents\Hunting\Coding Work Study\GitHub\Powershell\Month of Lunches\Labs\processes.html"

# Discovering object with Get-Member, aliased as `gm`
Get-process | Get-Member
Get-Process | gm