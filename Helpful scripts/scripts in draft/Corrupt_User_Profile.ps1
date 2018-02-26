# DESCRIPTION: Fix the Corrupt User Profile issue that happens on some windows 7 computers.
# based on MS KB ( https://support.microsoft.com/en-us/help/947215/you-receive-a-the-user-profile-service-failed-the-logon-error-message )

# METHOD 1 Scripting of the KB
# Prompt for username

# profile folder in Registry ( HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList )
# HELP ( https://blogs.technet.microsoft.com/heyscriptingguy/2011/11/10/use-powershell-to-find-user-profiles-on-a-computer/ )

$profilelist = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
dir $profilelist
Get-childItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' | % {Get-ItemProperty $_.pspath } | Select profileImagePath, sid


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