# Input ByValue
Get-Content .\computer.txt | Get-Service

Get-Help Get-Service -detailed
 
# 1st pipe out command A => Get-Member
Get-Content .\computer.txt | Get-Member

# 2nd examine the full help of command B
Get-Help Get-ADPrincipalGroupMembership -Full

#
Get-Process -name note* | Stop-Process
Get-Process -name chrome | Stop-Process

Get-Process | Get-Member

# 9.5
Get-help Get-ADuser -full > "C:\Users\lgrisby\Downloads\GitHub\Powershell\Saved Help Files\help_get-ADUser.txt"
Get-help *Export*CSV* -full

import-csv .\newusers.csv | New-ADUser
import-csv "C:\Users\lgrisby\Downloads\GitHub\Powershell\Month of Lunches\Labs\newusers.csv" | New-ADUser

"C:\Users\lgrisby\Downloads\GitHub\Powershell\Month of Lunches\Labs\ADUser-info-LGrisby.txt"

Get-ADUser -Filter 'surname -like "*Deasy*"' | FT Name, SamAccountName, DistinguishedName -A
Get-ADUser -Filter 'Name -like "patrick*"' | gm
Get-ADUser -Filter 'surname -like "*grisby"' | Out-File -FilePath "C:\Users\lgrisby\Downloads\GitHub\Powershell\Month of Lunches\Labs\Get-ADUser-info-.txt"

# Looking for matching usernames
Get-ADUser -Filter 'SamAccountName -like "MPallen*"' | Out-File -FilePath "H:\Work Temp File\1-Create AD Account\Get-ADUser-info-MPallen.txt"

#find groups the AD user is a member of
Get-ADPrincipalGroupMembership MPallen | select name | Out-File -FilePath "H:\Work Temp File\1-Create AD Account\Get-Groups-MPallen.txt"

# Copied from the book
import-csv .\newusers.csv |
select-object -property *,
@{name='samAccountName';expression={$_.login}},
@{label='Name';expression={$_.login}},
@{n='Department';e={$_.Dept}} |
New-ADUser



#Testing
Get-Help Get-ADComputer -Full

# search for computer information on the Domain Controller
Get-ADComputer "D-007" -Properties * | GM

# search a specific OU for computers in that OU
#this is all the computers in LKS11 OU
Get-ADComputer -Filter * -searchbase "OU=LKS11,OU=LKS,OU=Desktops,OU=Workstations,DC=BART,DC=DOMAIN" | Out-File -FilePath "C:\Users\lgrisby\Downloads\GitHub\Powershell\Month of Lunches\Labs\ADComputer-info-D007.txt"

# get a list of computer names
#research the output object
Get-ADComputer -Filter * -searchbase "OU=LKS11,OU=LKS,OU=Desktops,OU=Workstations,DC=BART,DC=DOMAIN" | Select-Object |GM
#select only the name and save that to a CSV file
Get-ADComputer -Filter * -searchbase "OU=LKS11,OU=LKS,OU=Desktops,OU=Workstations,DC=BART,DC=DOMAIN" | Select-Object name | Export-CSV -Path "C:\Users\lgrisby\Downloads\GitHub\Powershell\Month of Lunches\Labs\ADComputer-info-list of LKS11 computer names.txt"
