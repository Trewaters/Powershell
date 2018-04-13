# 10.2
Get-Process

# formatting directions for process objects are in DotNetTypes.format.ps1xml

# Find Power shell installation folder
cd $pshome
# dotnettypes.format.ps1xml
notepad dotnettypes.format.ps1xml

Get-Process | Get-Member

Get-WmiObject Win32_Operatingsystem | Get-Member

# Types.ps1xml stores the default Type Names that don't have specific formatting rules.
notepad Types.ps1xml

# 10.3 Formatting Tables
#autoSize
get-WmiObject Win32_BIOS | Format-table -AutoSize

#property
Get-Process | Format-Table -property *
Get-process | Format-Table -property ID,Name,Responding -AutoSize
Get-Process | Format-Table * -AutoSize
Get-Process | Sort-Object Name | Format-Table * -AutoSize

#groupBy
Get-Service | sort-Object status | Format-Table -GroupBy status

#wrap
Get-Service | Format-Table Name,status,displayname -AutoSize -wrap

