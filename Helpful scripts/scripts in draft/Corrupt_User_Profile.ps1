# DESCRIPTION: Fix the Corrupt User Profile issue that happens on some windows 7 computers.
# based on MS KB ( https://support.microsoft.com/en-us/help/947215/you-receive-a-the-user-profile-service-failed-the-logon-error-message )

# METHOD 1 Scripting of the KB
# Prompt for username
$winUser = Read-Host -Prompt 'Enter username'

# testing I have the correct username
#Write-Host "Fixing username $winUser."


# profile folder in Registry ( HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList )
# HELP with Registry Keys (https://docs.microsoft.com/en-us/powershell/scripting/getting-started/cookbooks/working-with-registry-keys?view=powershell-6)

$profilelist = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
# dir is an alias for 'Get-childItem'
#dir $profilelist
#dir $profilelist | format-List *

# abbreviated 
#Get-childItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' | % {Get-ItemProperty $_.pspath } | Select profileImagePath, sid
# detailed
Get-childItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' | ForEach-Object {Get-ItemProperty $_.pspath } | Select-Object profileImagePath, sid

# another way to access the same information
# abbreviated
#gwmi win32_userprofile | select localpath, sid
# detailed
#Get-WmiObject win32_userprofile | Select-Object localpath,sid
# how to get alias information for the commands used so far
#Get-Alias gwmi, select, ft
# show last time profile was used
#gwmi win32_userprofile | select @{LABEL="last used";EXPRESSION={$_.ConvertToDateTime($_.lastusetime)}}, LocalPath, SID | ft -a

#
$path = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*'
Get-ItemProperty -Path $path | Select-Object -Property PSChildName, ProfileImagePath
#
$objSID = New-Object System.Security.Principal.SecurityIdentifier("SID")
$objUser = $objSID.Translate( [System.Security.Principal.NTAccount])
$objUser.Value
#
$path = 'Registry::HKey_Local_Machine\Software\Microsoft\Windows NT\CurrentVersion\ProfileList\*'
$items = Get-ItemProperty -path $path
Foreach ($item in $items) {
    $objUser = New-Object System.Security.Principal.SecurityIdentifier($item.PSChildName)
    $objName = $objUser.Translate([System.Security.Principal.NTAccount])
    $item.PSChildName = $objName.value
}
echo $items | Select-Object -Property PSChildName, ProfileImagePath

# Get user profile path
Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' | ForEach-Object { $_.GetValue('ProfileImagePath') }
#ERROR - line below not working
#Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' | ForEach-Object { $profilePath = $_.GetValue('ProfileImagePath') Get-ChildItem -Path "$profilePath\AppData\Local\Temp" }

# windows user profile information
get-CIMinstance -ClassName win32_UserProfile | select -first 1
# extend to multiple machines like this
Get-WmiObject -Class Win32_UserProfile -ComputerName 'bit01','CLIENT2'
# HELP with $_ (https://technet.microsoft.com/en-us/library/ee677578.aspx)
# HELP with methods (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_methods?view=powershell-6)
# HELP with split (https://blogs.technet.microsoft.com/heyscriptingguy/2014/07/17/using-the-split-method-in-powershell/)
# Delete a user profile
#Get-WmiObject -Class Win32_UserProfile | where {$_.LocalPath.split('')[-1] -eq 'Users.Beverly'} | foreach {$_.Delete()}

Get-WmiObject -Class Win32_UserProfile -Property LocalPath 
Get-WmiObject -Class Win32_UserProfile | % {$_.LocalPath.split('\') } 
Get-WmiObject -Class Win32_UserProfile | where {$_.LocalPath.split('')[-1] -eq 'Users.Beverly'} | Out-String

# HELP if (https://mcpmag.com/articles/2016/03/09/working-with-the-if-statement.aspx)
# List user profiles that have not been used in 5 days
Get-WMIObject -class Win32_UserProfile | Where {(!$_.Special) -and ($_.ConvertToDateTime($_.LastUseTime) -lt (Get-Date).AddDays(-5))}
#Get-WMIObject -class Win32_UserProfile | % {($_.ConvertToDateTime($_.LastUseTime))}
Get-WMIObject -class Win32_UserProfile | % {if($_.LastUseTime -gt 0){($_.ConvertToDateTime($_.LastUseTime))} }

Get-WmiObject Win32_OperatingSystem | Get-Member -MemberType *method


#my steps
Set-Location 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'

Get-ChildItem

Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-21-3117278555-971133436-1423899629-7044'


# User Profile should start with an SID key = S-1-5...

# ProfileImagePath = "C:\Users\" + <CURRENT_USERNAME>

# Rename object (folder) without the ".bak" to ".ba"

# Rename object (folder) with the ".bak" to remove the ".bak"

# Rename object (folder) with ".ba" to ".bak"

# If there is only one folder, matching the <CURRENT_USERNAME> then remove the ".bak" from that object (folder)

# Update RefCount value = 0

# Update State value = 0

# Update RefCount value = 0

# Done. Close Open Connections, if any

# Restart computer, if no errors