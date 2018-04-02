# Format command from piped data.
Format-Table 

# Formats list as a table
Get-PSSnapin | Format-Table -Auto

<<<<<<< HEAD
# Powershell version
$PSVersionTable

=======
# Sort objects
Get-Process | Sort-Object -property ProcessName -Descending

# Select an object from the pipeline with `Select-Object`
Get-Process | Select-Object -property Name,ID,VM,PM | ConvertTo-HTML | Out-File selectObject_Test2.html
>>>>>>> 816744253d6ea32b7c50086e07370fa5b58f52b9
