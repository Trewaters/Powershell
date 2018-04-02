# Input ByValue
Get-Content .\computer.txt | Get-Service

Get-Help Get-Service -detailed
 
 # 1st pipe out command A => Get-Member
 Get-Content .\computer.txt | Get-Member

 # 2nd examine the full help of command B
 Get-Help Get-Service -Full

 #
 Get-Process -name note* | Stop-Process
 Get-Process -name chrome | 

 Get-Process | Get-Member

 Get-help Stop-Process -full

 Get-help *total* -full
