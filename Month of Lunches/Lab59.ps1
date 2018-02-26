cd HKCU:\software\microsoft\Windows\CurrentVersion\Explorer
cd advanced
Set-ItemProperty -Path. -Name DontPrettyPath -Value 1

# Lab

# 1. In the Registry, go to HKEY_CURRENT_USER\software\microsoft\Windows\-currentversion\explorer. Locate the Advanced key, and set its DontPrettyPath property to 1.
New-Item -path C:\Labs

# 2. Create a new directory called C:\Labs.
New-Item -path "C:\Users\Tre'\Documents\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs" -itemType Directory

# 3. Create a zero-length file named C:\Labs\Test.txt (use New-Item).
New-Item -path "C:\Users\Tre'\Documents\Hunting\Coding Work Study\Powershell\Month of Lunches\Labs" -Name text.txt -ItemType file

# 5. Using the Environment provider, display the value of the system environment variable %TEMP%.
Get-item env:temp