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
# with delay this should last 15 minutes.
Test-Connection "d-dwatry" -Count 300 -Delay 3

# BART EXAMPLE
# Computer List I can test D-GGrove, ess.bart.gov, D-Alowery2, OHYForewker2-w7, ITHD-Extra

Test-Connection "ess.bart.gov"


# Testing

Get-Help Get-WmiObject -Detailed
Get-Help Get-CimInstance -Detailed
Get-CimInstance -ClassName Win32_Process

Get-CimInstance -ClassName Win32_NetworkAdapter
Get-WmiObject -Class Win32_NetworkAdapter

Get-CimInstance –Namespace root –ClassName __Namespace