
::REM get username
::REM run ipconfig /all
::REM save ipconfig all to a text file in Temp drive
ipconfig /all > \\bart.domain\Public\Temp\lgrisby\x\%USERNAME%-%COMPUTERNAME%-ipconfig.txt
