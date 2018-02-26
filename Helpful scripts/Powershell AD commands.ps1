#
get-adgroup -filter *  | sort name | select Name

# Get-ADGroup help ( https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617196(v=technet.10)#input-type )

# Get a list of Groups from AD and save to csv
#-blog post ( https://www.toddlamothe.com/technology/powershell-list-groups-active-directory.htm )
$filename = "C:\Users\lgrisby\AppData\Local\Temp\ExportedGroups.csv"
Get-ADGroup -Filter '*' | select-object * | where-object {$_.distinguishedname -like "*,OU=Container,*"} |Export-Csv -Path $filename

# blog for listing ad ( https://www.petri.com/powershell-problem-solver-exporting-active-directory-groups-csv )
# List filtered information and saves to csv
Get-ADGroupMember -Identity "cc_Common_Expense" | 
Select Name,SamAccountName,DistinguishedName | 
Export-CSV -Path C:\Users\lgrisby\AppData\Local\Temp\ADGroupMembers.csv -NoTypeInformation

# counts
Get-ADGroupMember -Identity "cc_Common_Expense" | Group ObjectClass

# Get domain controller for the forest
Get-ADDomainController -Discover -Service "GlobalCatalog"