# check version of powershell installed
$psversionTable

dir

# clear screen
cls
Clear-Host

# get alias real command
get-alias

# open help in a new window
Get-Help about_Variables -ShowWindow

# create a file
Out-File FILENAME.txt -Append -Force

# Remote sessions
# Verify status of Windows Remote management Service
Winrm quickconfig

# verify Execution policy for running powershell scripts
Get-ExecutionPolicy
# enable remote execution
Set-ExecutionPolicy RemoteSigned
# enable remoting
Enable-PSremoting -force
# Use one to one remoting
Enter-PSSession -ComputerName COMPUTER_NAME
Get-Service SERVICE_NAME #as an example I am on another computer.
Exit-PSSession #end remote session

Get-Process #?

# One to Many connection
Invoke-Command –ComputerName COMPUTER_NAME_1 , COMPUTER_NAME_2 –ScriptBlock {Get-EventLog –log system} #multiple computers are comma delimeted

# Persistent session
$s = New-PSWorkflowSession –ComputerName COMPUTER_NAME #create persistent connection and assign to a variable.
Enter-PSSession $s #start and connect to interactive session
Disconnect-PSSession #disconnect client but leave persistent connection active
Exit-PSSession #close and disconnect interactive session
Receive-PSSession #get results of disconnected session

Get-PSSession -ComputerName COMPUTER_NAME #list persistent sessions on computer
Connect-PSSession SESSION_NAME #re-connect to a disconnected session

