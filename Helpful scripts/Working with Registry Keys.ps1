# Working with Registry Keys
# MS Doc for Powershell 6. Working with Registry Keys ( https://docs.microsoft.com/en-us/powershell/scripting/getting-started/cookbooks/working-with-registry-keys?view=powershell-6 )

# This command displays items directly within Windows PowerShell drive HKCU
Get-ChildItem -Path hkcu:\
# using `::` after the Registry providers full name will work for the path in a hive. Any of the commands below are acceptable.
Get-ChildItem -Path Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Registry::HKCU
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKCU
Get-ChildItem HKCU:

#DEFINITION - Registry Hives ( https://msdn.microsoft.com/en-us/library/windows/desktop/ms724877(v=vs.85).aspx )

# Using `-Recurse` list all items within each object
Get-ChildItem -Path hkcu:\ -Recurse

# Use `Where-Object` to filter on properties
Get-ChildItem -Path HKCU:\Software -Recurse | Where-Object -FilterScript {($_.SubKeyCount -le 1) -and ($_.ValueCount -eq 4) }

##Copying Keys
#Copying is done with Copy-Item. The following command copies HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion and all of its properties to HKCU:\, 
#creating a new key named "CurrentVersion":

Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu:

#If you examine this new key in the registry editor or by using Get-ChildItem, 
#you will notice that you do not have copies of the contained subkeys in the new location. 
#In order to copy all of the contents of a container, you need to specify the Recurse parameter. 
#To make the preceding copy command recursive, you would use this command:

Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu: -Recurse

#You can still use other tools you already have available to perform filesystem copies. 
#Any registry editing tools—including reg.exe, regini.exe, and regedit.exe—and COM objects that support 
#registry editing (such as WScript.Shell and WMI's StdRegProv class) can be used from within Windows PowerShell.

##Creating Keys
#Creating new keys in the registry is simpler than creating a new item in a file system. Because all registry keys are containers, you do not need to specify the item type; you simply supply an explicit path, such as:

New-Item -Path hkcu:\software_DeleteMe
#You can also use a provider-based path to specify a key:

New-Item -Path Registry::HKCU_DeleteMe

##Deleting Keys
#Deleting items is essentially the same for all providers. The following commands will silently remove items:

Remove-Item -Path hkcu:\Software_DeleteMe
Remove-Item -Path 'hkcu:\key with spaces in the name'
##Removing All Keys Under a Specific Key
#You can remove contained items by using Remove-Item, but you will be prompted to confirm the removal if the item contains anything else. For example, if we attempt to delete the HKCU:\CurrentVersion subkey we created, we see this:

Remove-Item -Path hkcu:\CurrentVersion

#To delete contained items without prompting, specify the -Recurse parameter:

Remove-Item -Path HKCU:\CurrentVersion -Recurse

#If you wanted to remove all items within HKCU:\CurrentVersion but not HKCU:\CurrentVersion itself, you could instead use:

Remove-Item -Path HKCU:\CurrentVersion\* -Recurse