# link to AD commands ( https://technet.microsoft.com/en-us/library/ee617195.aspx )

Disable-ADAccount -Identity USERNAME

Enable-ADAccount -Identity USERNAME

Get-ADAccountAuthorizationGroup -Identity USERNAME #No wild cards allowed

Get-ADComputer -Filter {Name -like "*"} #Filter all computers

Get-ADUser -Filter *
Get-ADUser -Filter {EmployeeID -like "*"}

Move-ADObject

New-ADComputer

New-ADUser

Remove-ADComputer

Remove-ADUser

Set-ADComputer

Search-ADAccount

Set-ADDomain

Set-ADUser