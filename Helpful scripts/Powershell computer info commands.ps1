# Computer ipV4 address
# help ( https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-5.1 )
Test-Connection -ComputerName (hostname) -Count 1 | Select IPV4Address

# Other ways to get IP address with powershell check this link ( https://www.petri.com/powershell-problem-solver-find-ip-address-using-powershell )
$PSVersionTable

# blog post about $env variable ( https://ss64.com/ps/syntax-env.html )
# Get username
$env:UserName

# Get Computer Name
$env:COMPUTERNAME

# Get domain name
$env:UserDomain
$env:USERDNSDOMAIN

#Get LogonServer
$env:LOGONSERVER

# list all environmental variables
Get-ChildItem env:
# or use `gci`
gci env: | sort name

# restart local computer
Restart-Computer
# Restart remote computer
Restart-Computer -ComputerName "COMPUTER_NAME" -Impersonation Anonymous -Authentication PacketIntegrity
