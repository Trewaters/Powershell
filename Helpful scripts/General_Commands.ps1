# Format command from piped data.
Format-Table 

# Formats list as a table
Get-PSSnapin | Format-Table -Auto

# Sort objects
Get-Process | Sort-Object -property ProcessName -Descending

# Select an object from the pipeline with `Select-Object`
Get-Process | Select-Object -property Name,ID,VM,PM | ConvertTo-HTML | Out-File selectObject_Test2.html
