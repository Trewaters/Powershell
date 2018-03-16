# import commads
import-module grouppolicy

# list all Group Policy Commands
Get-Command -module grouppolicy

# Get inheritance for a Target
Get-GPInheritance -Target "OU=eBART BART-to-OAK,OU=EndUsers,DC=BART,DC=DOMAIN"
# Shows the linked policy information
(Get-GPInheritance -Target "OU=eBART BART-to-OAK,OU=EndUsers,DC=BART,DC=DOMAIN").GpoLinks | foreach-object { Get-GPO -Name ($_.DisplayName)}

# This doesn't work on my windows 7 computer.
# help page ( https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617241(v%3dtechnet.10) )
Get-ADUser -Filter * -SearchBase "OU=Stations,OU=Transit System Development,OU=EndUsers,DC=BART,DC=DOMAIN"

# Get all GPOs
# Got this from here ( https://gallery.technet.microsoft.com/PowerShell-Script-to-eed7188a ). 
# Still trying to see what it does
Get-GPOReport -All -ReportType HTML -Path C:\Users\lgrisby\AppData\Local\Temp\GPO.html
# Limit result to specific GPO
Get-GPOReport -Name "Map G Drive [eBART OAC]" -ReportType HTML -Path C:\Users\lgrisby\AppData\Local\Temp\GPO_REport_name.html
# saves the report as xml
[xml] $xml = Get-GPOReport -Name "Map G Drive [eBART OAC]" -ReportType XML
# resources ( https://www.red-gate.com/simple-talk/sysadmin/powershell/powershell-data-basics-xml/ )


# Look at entire GPO and filter return to XML
# got from this link ( https://social.technet.microsoft.com/Forums/windowsserver/en-US/de1431b6-190c-4779-8b44-b2c33b22fc15/powershell-determining-if-a-gpo-is-linked?forum=winserverpowershell )
# Link working with XML ( https://blogs.technet.microsoft.com/heyscriptingguy/2012/03/25/the-scripting-wife-learns-to-use-powershell-to-work-with-xml/ )
# more xml links ( https://www.red-gate.com/simple-talk/sysadmin/powershell/powershell-data-basics-xml/ )
# more xml links ( https://blogs.technet.microsoft.com/heyscriptingguy/2013/02/07/use-powershell-to-generate-and-parse-a-group-policy-object-report/ )


## START
Function Get-AllGPO
{
	Get-GPOReport -all -ReportType xml | %{
		([xml]$_).gpo | select name,@{n="SOMName";e={$_.LinksTo | % {$_.SOMName}}},@{n="SOMPath";e={$_.LinksTo | %{$_.SOMPath}}}
	}
}

#Get Gpo with name Map* and display what OU is linked.
Get-AllGPO | ? {$_.Name -match "Map*"} | %{$_.SomName}
## END

# Gets all the GPO names
Get-GPO -All | ForEach-Object {       
    ([XML](Get-GPOReport -Guid $_.ID -ReportType Xml) | Where-Object {$_.GPO.User.ExtensionData -ne $null}).GPO.Name    
}

# details for Group Policy
Get-GPO "Map G Drive [eBART OAC]"

# HELP post on auditing GPO changes ( https://blogs.technet.microsoft.com/ashleymcglone/2015/01/26/forensics-audit-group-policy-links-and-changes-with-powershell/ )


# TEST
Get-GPOReport -Name "Map G Drive [eBART OAC]" -ReportType HTML -Path C:\Users\lgrisby\AppData\Local\Temp\GPO_REport_name.html

Get-GPOReport -Name "Map G Drive [eBART OAC]" -ReportType XML

# saves the report as xml
[xml] $xml = Get-GPOReport -Name "Map G Drive [eBART OAC]" -ReportType XML


$xml.Name | % {$_.mainsection.title}

$xml.DocumentElement.Name #gives name of the GPO

$xml.GPO.User.ExtensionData.Extension.DriveMapSettings
$xml.GPO.User.ExtensionData.Value

# Gets all the GPO names
Get-GPO -All | ForEach-Object {
       
    ([XML](Get-GPOReport -Guid $_.ID -ReportType Xml) | Where-Object {$_.GPO.User.ExtensionData -ne $null}).GPO.Name
    
}

# EXAMINE before running. This tries to make changes. I commented them out.
Get-GPO -All | Sort-Object displayname | Where-Object { If ( $_ | Get-GPOReport -ReportType XML | Select-String -NotMatch "&lt;LinksTo&gt;" )
{
#Backup-GPO -name $_.DisplayName -path C:\Users\Public\GPOBackups
#$_.DisplayName | Out-File .\UnLinkedGPOS.txt -Append
#$_.Displayname | remove-gpo -Confirm
}}

# HELP local group policy ( http://brandonpadgett.com/powershell/Local-gpo-powershell/ )
# HELP MS Docs on local group policy ( https://docs.microsoft.com/en-us/powershell/module/grouppolicy/?view=win10-ps )
