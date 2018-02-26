REM Compliance Check SCRIPT
REM Reference: http://www.techrepublic.com/forum/questions/101-215911/dos-command-to-list-all-installed-programs

REM This will check for the installed programs. We want to make sure the user has the standard programs installed. We will also see what version they have of the program. 

REM Check for specific programs. Standard BART applications 

REM ---

REM Installed Programs are in  
reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall temp1-compliance.txt
reg export HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall tempMachineWow1-compliance.txt
reg export HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall tempUser1-compliance.txt

REM I need to get the version number too... not sure how to add it yet
find "DisplayName" temp1-compliance.txt > temp2-compliance.txt
find "DisplayName" tempUser1-compliance.txt > tempUser2-compliance.txt
find "DisplayName" tempMachineWow1-compliance.txt > tempMachineWow2-compliance.txt


for /f "tokens=2,3 delims==" %%a in (temp2-compliance.txt) do (echo %%a >> \\bart.domain\Public\Temp\lgrisby\x-compliance\%USERNAME%-%COMPUTERNAME%-software_list.txt)
for /f "tokens=2,3 delims==" %%a in (tempUser2-compliance.txt) do (echo %%a >> \\bart.domain\Public\Temp\lgrisby\x-compliance\%USERNAME%-%COMPUTERNAME%-software_list.txt)
for /f "tokens=2,3 delims==" %%a in (tempMachineWow2-compliance.txt) do (echo %%a >> \\bart.domain\Public\Temp\lgrisby\x-compliance\%USERNAME%-%COMPUTERNAME%-software_list.txt)

REM - Microsoft Office 365, OneDrive, Skype, Visio, Project, AutoCAD, Adobe Acrobat Pro XI, Adobe Acrobat DC, 7-Zip, McAfee
REM - "g:compliance-list.txt" has some of the software that we install for users, but it doesn't have all the software.
REM - removed the find string line until we have a list of standard applications and a good way to mark if the computer is not compliant.
REM findstr /n /g:compliance-list.txt *compliance.txt >> \\bart.domain\Public\Temp\lgrisby\x-compliance\%USERNAME%-%COMPUTERNAME%-compliance.txt

del temp1-compliance.txt
del temp2-compliance.txt
del tempUser1-compliance.txt
del tempUser2-compliance.txt
del tempMachineWow1-compliance.txt
del tempMachineWow2-compliance.txt
