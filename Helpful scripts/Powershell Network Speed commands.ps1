# Get network adapter information
Get-WmiObject -ComputerName (hostname) -Class Win32_NetworkAdapter | `
    Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | `
    Format-Table -Property SystemName,Name,NetConnectionID,Speed

# Format network speed for GB, otherwise same as above command.
Get-WmiObject -ComputerName (hostname) -Class Win32_NetworkAdapter | `
    Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | `
    Format-Table -Property NetConnectionID,@{Label='Speed(GB)'; Expression = {$_.Speed/1GB}}
      
# Get network numbers, not sure what to do with this information            
Get-WmiObject -Namespace root\wmi -Class MSNdis_LinkSpeed `
-ComputerName "D-007" | 
foreach {            
 $nic = Get-WmiObject -Class Win32_NetworkAdapter `
 -ComputerName "D-007" -Filter "Name = '$($_.InstanceName)'"            
            
New-Object -TypeName PSObject -Property @{            
 Name = $_.InstanceName            
 NdisLinkSpeed = $_.NdisLinkSpeed            
 TestNdis = $_.NdisLinkSpeed / 10000            
 Speed = $nic.Speed            
 Test = $nic.Speed / 1000000            
} | select Name, NdisLinkSpeed, TestNdis, Test, Speed            
            
}            

# Same as Ping
Test-Connection "D-BSpring" -Count 1000



Get-Help Test-Connection -Detailed

# BART EXAMPLE

Test-Connection "ess.bart.gov"