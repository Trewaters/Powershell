# Type this `.\ComputerInfo.ps1 > TestRun.txt`

# Computer ipV4 address
# help ( https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-5.1 )
Test-Connection -ComputerName (hostname) -Count 1 | Select IPV4Address

# blog post about $env variable ( https://ss64.com/ps/syntax-env.html )
# Get username
"username: " + $env:UserName

# Get Computer Name
"Computer Name: " + $env:COMPUTERNAME

# Get domain name
"User Domain: " + $env:UserDomain
"User DNS Domain: " + $env:USERDNSDOMAIN

#Get LogonServer
"Computer Logon Server: " + $env:LOGONSERVER
