set-location -Path hkcu:
set-location -Path software
Get-ChildItem
set-location microsoft
get-ChildItem
Set-Location .\Windows
Get-ChildItem
Set-ItemProperty -Path dwm -PSProperty EnableAeroPeek -Value 1 # 0 = disabled, 1 = enabled