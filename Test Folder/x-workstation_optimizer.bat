::REM change directory to C
cd\
C:

::REM return a "n" No for logging off the computer.
echo n | gpupdate /force

::REM save the group policy result for later.
gpresult /r > T:\lgrisby\x-optimize\%COMPUTERNAME%-%USERNAME%-gpResult.txt

::REM      Delete temp files and folders,  
rmdir C:\Windows\TEMP /s /q
rmdir %USERPROFILE%\AppData\Local /s /q
::REM `md %temp%` - not sure this is needed

::REM `rmdir` reference https://technet.microsoft.com/en-us/library/bb490990.aspx
::REM `md` reference https://technet.microsoft.com/en-us/library/bb490930.aspx

::REM      update McAfee security,  
::REM Find where the cmdagent.exe is locate
::REM `cmdagent.exe /c` will refresh policies and initiate them immediately
::REM https://kc.mcafee.com/corporate/index?page=content&id=KB52707
if exist "C:\Program Files\McAfee\Agent\cmdagent.exe" (
    cd C:\Program Files\McAfee\Agent
    cmdagent.exe /c
)else (
    echo no McAfee Agent file installed C:\Program Files\McAfee\Agent\cmdagent.exe
    ::REM Do Nothing
)

exit