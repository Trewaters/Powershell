# open powershell with command line
# import-module allows extending the shell
%windir%\system32\WindowsPowerShell\v1.0\powershell.exe -noexit -command import-module ActiveDirectory

# RESEARCH: console file for automatically loading snap-ins. see how they can be helpful.

# see available snap-ins
Get-PSSnapin -Registered

# add snap-in
Add-PSSnapin
# remove snap-in
Remove-PSSnapin
# see what is loaded for a specifically installed snapin
Get-Command -pssnapin WDeploySnapin3.0
# see any PSDrive providers, check for new ones installed with snapin
Get-PSProvider

# Modules
# find module path for powershell
Get-Content env:psmodulepath
# gets a list of installed modules
Get-Module
Remove-module

# Finding new modules and commands
Get-Help *dns*
# Found a DnsClient module in the help
Import-Module -name DnsClient #load module
get-command -Module DnsClient #list commands
Get-Help Clear-DnsClientCache
Clear-DnsClientCache -verbose #added verbose to see what the command did

# Preloading extension when the shell starts
# Three ways to auto load modules and/or snap-ins
# 1
# creates an XML file that list only snap-ins that are loaded
Export-Console "C:\Users\Tre'\SkyDrive\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs\myshell.psc"
# use the following command line to open powershell with config file
%windir%\system32\WindowsPowerShell\v1.0\powershell.exe -noexit -psconsolefile "C:\Users\Tre'\SkyDrive\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs\myshell.psc"

$profile
# C:\Users\Tre'\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1
# in new location create a filed named 'profile.ps1'
# following commmands should be in the 'profile.ps1' file
Add-PSSnapin
Import-Module
# in the shell make sure script execution is allowed
Set-executionPolicy RemotedSigned
# find modules in 'http://www.powershellgallery.com/'
# version 5 > of Powershell has this gallery already
Register-PSRepository
Find-Module
Install-Module
Update-Module

$PSVersionTable
