@echo off
title ShivUmang Optimization
color 0A
chcp 65001 >nul

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Right-click the script and choose "Run as administrator."
    pause
    exit /b
)

:menu
cls
echo =====================================
echo [38;5;214m ░██████╗██╗░░██╗██╗██╗░░░██╗██╗░░░██╗███╗░░░███╗░█████╗░███╗░░██╗░██████╗░
echo [38;5;215m██╔════╝██║░░██║██║██║░░░██║██║░░░██║████╗░████║██╔══██╗████╗░██║██╔════╝░
echo [38;5;216m╚█████╗░███████║██║╚██╗░██╔╝██║░░░██║██╔████╔██║███████║██╔██╗██║██║░░██╗░
echo [38;5;217m░╚═══██╗██╔══██║██║░╚████╔╝░██║░░░██║██║╚██╔╝██║██╔══██║██║╚████║██║░░╚██╗
echo [38;5;218m██████╔╝██║░░██║██║░░╚██╔╝░░╚██████╔╝██║░╚═╝░██║██║░░██║██║░╚███║╚██████╔╝
echo [38;5;219m╚═════╝░╚═╝░░╚═╝╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░[0m
echo =====================================
echo [1] Permanently Disable Windows Defender
echo [2] Temporarily Disable Windows Defender
echo [3] Boost PC (Disable UAC)
echo [4] Disable Defender via Registry File
echo [0] Exit
echo =====================================
set /p choice="Enter your choice: "

if "%choice%"=="1" goto Disable_Defender
if "%choice%"=="2" goto Disable_Defender_Temp
if "%choice%"=="3" goto Boost_PC
if "%choice%"=="4" goto Regedit_Defender
if "%choice%"=="0" exit
goto menu

:Disable_Defender
cls
echo ==========================
echo Disabling Windows Defender Permanently...
echo ==========================
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v DisableSpecialRunningModes /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f
sc stop WinDefend
sc config WinDefend start= disabled
echo.
echo ✅ Windows Defender permanently disabled.
pause
goto menu

:Disable_Defender_Temp
cls
echo ==========================
echo Temporarily Disabling Windows Defender...
echo ==========================
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1
echo.
echo ⏱ Windows Defender temporarily disabled.
pause
goto menu

:Boost_PC
cls
echo ==========================
echo Boosting this PC...
echo ==========================
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
echo.
echo ⚡ Boost complete. Please restart your computer for changes to take effect.
pause
goto menu

:Regedit_Defender
cls
echo ==========================
echo Disabling Defender using Registry File...
echo ==========================
set "regFile=%temp%\DisableDefender.reg"
(
echo Windows Registry Editor Version 5.00
echo.
echo ; youtube.com/AdamxYT
echo ; Registry File By Adamx
echo.
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend]
echo "Start"=dword:00000004
echo.
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService]
echo "Start"=dword:00000004
echo.
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc]
echo "Start"=dword:00000004
echo.
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense]
echo "Start"=dword:00000004
echo.
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc]
echo "Start"=dword:00000004
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender]
echo "DisableAntiSpyware"=dword:00000001
echo "DisableRoutinelyTakingAction"=dword:00000001
echo "ServiceKeepAlive"=dword:00000000
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection]
echo "DisableBehaviorMonitoring"=dword:00000001
echo "DisableIOAVProtection"=dword:00000001
echo "DisableOnAccessProtection"=dword:00000001
echo "DisableRealtimeMonitoring"=dword:00000001
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting]
echo "DisableEnhancedNotifications"=dword:00000001
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications]
echo "DisableNotifications"=dword:00000001
echo.
echo [HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
echo "NoToastApplicationNotification"=dword:00000001
echo "NoToastApplicationNotificationOnLockScreen"=dword:00000001
) > "%regFile%"

reg import "%regFile%"
del "%regFile%"
echo.
echo 📁 Registry successfully applied to disable Defender.
pause
goto menu
