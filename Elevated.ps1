﻿<#
    .SYNOPSIS

    Multi-Platform configuration script for Windows 10 Enterprise LTSC 1809 (x64).
#>


<#
Global Variables
#>
$ErrorActionPreference = 'SilentlyContinue'
del Log.log; Start-Transcript -Path 'Log.log'

<#
Fetch Administrator SID for later HKCU injection through SYSTEM account, and mount.
Also Mount HKEY_CLASSES_ROOT.
#>
Write-Host "Fetching Administrator Account SID" -ForegroundColor Green
$objUser = New-Object System.Security.Principal.NTAccount("Administrator")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$strSID.Value
Write-Host "Mount Administrator Registry Hive with alias HKU:\" -ForegroundColor Green
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS\$strSID
New-PSDrive -PSProvider Registry -Name HKCR -Root HKEY_CLASSES_ROOT


<# First remove capabilities and features before further configuration. #>
Write-Host "Changing Windows Capabilities..." -ForegroundColor Green

if((Get-WindowsCapability -Name 'App.Support.QuickAssist~~~~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'App.Support.QuickAssist~~~~0.0.1.0'
}
if((Get-WindowsCapability -Name 'Hello.Face.17658~~~~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'Hello.Face.17658~~~~0.0.1.0'
}
if((Get-WindowsCapability -Name 'Hello.Face.Migration.17658~~~~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'Hello.Face.Migration.17658~~~~0.0.1.0'
}
if((Get-WindowsCapability -Name 'Language.Handwriting~~~en-US~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'Language.Handwriting~~~en-US~0.0.1.0'
}
if((Get-WindowsCapability -Name 'MathRecognizer~~~~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'MathRecognizer~~~~0.0.1.0'
}
if((Get-WindowsCapability -Name 'Media.WindowsMediaPlayer~~~~0.0.12.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'Media.WindowsMediaPlayer~~~~0.0.12.0'
}
if((Get-WindowsCapability -Name 'OneCoreUAP.OneSync~~~~0.0.1.0' -Online).State -eq "Installed") {
    Remove-WindowsCapability -Online -Name 'OneCoreUAP.OneSync~~~~0.0.1.0'
}

Write-Host "Changing Windows Optional Features..." -ForegroundColor Green

if((Get-WindowsOptionalFeature -FeatureName 'Internet-Explorer-Optional-amd64' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Internet-Explorer-Optional-amd64' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'SmbDirect' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'SmbDirect' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'SMB1Protocol' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'SMB1Protocol' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Microsoft-Windows-Client-EmbeddedExp-Package' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Client-EmbeddedExp-Package' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'WindowsMediaPlayer' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'WCF-TCP-PortSharing45' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'WCF-TCP-PortSharing45' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'WCF-Services45' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'WCF-Services45' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Printing-Foundation-InternetPrinting-Client' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-Foundation-InternetPrinting-Client' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'FaxServicesClientPackage' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'FaxServicesClientPackage' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Printing-Foundation-Features' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-Foundation-Features' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'WorkFolders-Client' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'MSRDC-Infrastructure' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'MSRDC-Infrastructure' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'SearchEngine-Client-Package' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'SearchEngine-Client-Package' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Printing-PrintToPDFServices-Features' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-PrintToPDFServices-Features' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Printing-XPSServices-Features' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-XPSServices-Features' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'Windows-Defender-Default-Definitions' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'Windows-Defender-Default-Definitions' -NoRestart
}
if((Get-WindowsOptionalFeature -FeatureName 'NetFx4-AdvSrvs' -Online).State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName 'NetFx4-AdvSrvs' -NoRestart
}


<# Install runtime libraries #>
Write-Host "Installing DX9 Runtime if not installed..." -ForegroundColor Green

if(!(Test-Path -Path "C:\Windows\System32\D3DX9_43.dll")) {
    & ./'Runtime Libraries\DX Runtime June 2010\DXSETUP.exe' /silent | Out-Null
}

Write-Host "Installing Visual C++ Runtime libraries if not installed..." -ForegroundColor Green

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2005")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2005_x86.exe' /q | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2005_x64.exe' /q | Out-Null
}

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2008")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2008_x86.exe' /qb | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2008_x64.exe' /qb | Out-Null
}

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2010")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2010_x86.exe' /passive /norestart | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2010_x64.exe' /passive /norestart | Out-Null
}

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2012")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2012_x86.exe' /passive /norestart | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2012_x64.exe' /passive /norestart | Out-Null
}

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2013")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2013_x86.exe' /passive /norestart | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2013_x64.exe' /passive /norestart | Out-Null
}

$Check=@(gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*").DisplayName
if (!($Check -match "C\+\+ 2019")) {
    & ./'Runtime Libraries\Visual Runtime\vcredist2015_2017_2019_x86.exe' /passive /norestart | Out-Null
    & ./'Runtime Libraries\Visual Runtime\vcredist2015_2017_2019_x64.exe' /passive /norestart | Out-Null
}


<# Change Registry Permissions #>
Write-Host "Changing Registry Permissions" -ForegroundColor Green
#& .\SetACL.exe -on "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" -ot reg -actn setowner -ownr "n:Administrators" -rec Yes
#& .\SetACL.exe -on "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" -ot reg -actn ace -ace "n:Administrators;p:full" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Drive\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Drive\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Directory\Background\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Directory\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators" -rec Yes
& .\SetACL.exe -on "HKEY_CLASSES_ROOT\Directory\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full" -rec Yes


<# Disallowed processes #>
Write-Host "Block Specified Executables from Running" -ForegroundColor Green
#New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" | New-ItemProperty -Name Debugger -PropertyType String -Value "%windir%\System32\systray.exe" -Force
#New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\slui.exe" | New-ItemProperty -Name Debugger -PropertyType String -Value "%windir%\System32\systray.exe" -Force
#New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GameBarPresenceWriter.exe" | New-ItemProperty -Name Debugger -PropertyType String -Value "%windir%\System32\systray.exe" -Force


<# Adjust Services #>
Write-Host "Adjusting services start type..." -ForegroundColor Green

$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\luafv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\TrkWks"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WpnUserService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CDPUserSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\cbdhsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WpnService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\BDESVC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\BITS"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CDPSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DoSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DPS"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DusmSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\iphlpsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\ShellHWDetection"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\smphost"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Spooler"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\SstpSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\TabletInputService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\UsoSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WdiServiceHost"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WdiSystemHost"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DsmSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\NcbService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WPDBusEnum"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WbioSrvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\UnistoreSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\UserDataSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WerSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wisvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\MapsBroker"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\XblAuthManager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\LxpSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\StorSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\PolicyAgent"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\IKEEXT"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\NgcSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\LicenseManager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wlidsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\TokenBroker"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\PhoneSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\NcaSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\irmon"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\fdPHost"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\FDResPub"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\fhsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\ScDeviceEnum"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CertPropSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\SessionEnv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\TermService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 2 -Force
#$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Psched"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CSC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CscService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wanarp"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\volmgrx"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
#$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\QWAVE"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
#$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\QWAVEdrv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\stisvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 3 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 3 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Vid"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\spaceport"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\kdnic"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\rdpbus"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\BcastDVRUserService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\SecurityHealthService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wscsvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\storqosflt"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\rspndr"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\MsLldp"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\lltdio"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\gencounter"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\CldFlt"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\SgrmBroker"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Themes"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\SgrmAgent"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\tsusbhub"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBIOS"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\wcifs"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\FileCrypt"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Dfsc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\cdrom"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 3 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\afunix"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\vwififlt"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\MSDTC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\bam"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\bthserv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DeviceAssociationService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\BthAvctpSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\iaStorAfsService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\RstMwService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\IAStorDataMgrSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DelayedAutostart" -PropertyType DWord -Value 0 -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\MSDTC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\bam"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\bthserv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\DeviceAssociationService"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\BthAvctpSvc"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Audiosrv"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Start" -PropertyType DWord -Value 4 -Force
    }


# Adjust Services Trigger/Failure Settings
sc.exe failure wuauserv actions= '""' reset= '""'
sc.exe triggerinfo wuauserv delete # We only want to trigger Windows Update service on manual cumulative updating.


<# Adjust Autorun Entries #>
Write-Host "Adjusting Autorun Entries" -ForegroundColor Green
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Drivers" -Name "Adobe Type Manager"
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" -Name msacm.l3acm -PropertyType String -Value "" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" -Name msacm.l3acm -PropertyType String -Value "" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" -Name vidc.cvid -PropertyType String -Value "" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" -Name VIDC.RTV1 -PropertyType String -Value "" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" -Name VIDC.RTV1 -PropertyType String -Value "" -Force
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth"

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name IAStorIcon -PropertyType String -Value '"C:\Program Files\Intel\Intel(R) Rapid Storage Technology\IAStorIconLaunch.exe" "C:\Program Files\Intel\Intel(R) Rapid Storage Technology\IAStorIcon.exe" 5' -Force
    }


<# Disable Windows Components through Registry #>
Write-Host "Disable Windows Components through Registry." -ForegroundColor Green
# User Account Control
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableLUA" -PropertyType DWord -Value 0 -Force
# Windows Defender (Also disables two more services after reboot)
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableAntiSpyware" -PropertyType DWord -Value 1 -Force
# System Restore
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableSR" -PropertyType DWord -Value 1 -Force
# Remote Assistance
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "fAllowFullControl" -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path $Path -Name "fAllowToGetHelp" -PropertyType DWord -Value 0 -Force
# Disk Quota
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DiskQuota"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Enable" -PropertyType DWord -Value 0 -Force
# SmartScreen
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableSmartScreen" -PropertyType DWord -Value 0 -Force
# PeopleBar/PeopleExperienceHost
$Path = "HKU:\Software\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HidePeopleBar" -PropertyType DWord -Value 1 -Force
# Previous Versions
$Path = "HKLM:\Software\Policies\Microsoft\PreviousVersions"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableBackupRestore" -PropertyType DWord -Value 1 -Force
$Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoPreviousVersionsPage" -PropertyType DWord -Value 1 -Force
# Offline Files
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetCache"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Enabled" -PropertyType DWord -Value 0 -Force
# File History
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\FileHistory"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Disabled" -PropertyType DWord -Value 1 -Force
# Restore
New-Item -ItemType String -Path "HKLM:\Software\Policies\Microsoft\Windows\Backup"
$Path = "HKLM:\Software\Policies\Microsoft\Windows\Backup\Client"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableRestoreUI" -PropertyType DWord -Value 1 -Force
New-ItemProperty -Path $Path -Name "DisableBackupUI" -PropertyType DWord -Value 1 -Force
# AutoPlay (Disable for All Drives)
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoDriveTypeAutoRun" -PropertyType DWord -Value 255 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableAutoplay" -PropertyType Dword -Value 1 -Force
# Mobility Center
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoMobilityCenter" -PropertyType DWord -Value 1 -Force
# Taskview (+Taskbar Icon)
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowTaskViewButton" -PropertyType Dword -Value 0 -Force
# Notification Center (+Taskbar Icon)
$Path = "HKU:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableNotificationCenter" -PropertyType Dword -Value 1 -Force
# CD Burning
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoCDBurning" -PropertyType Dword -Value 1 -Force
# Miracast
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "PlatformSupportMiracast" -PropertyType Dword -Value 0 -Force
# Phone Linking / Shared Experience
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableMmx" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnableCdp" -PropertyType Dword -Value 0 -Force
# SettingSync
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableSettingSync" -PropertyType Dword -Value 2 -Force
New-ItemProperty -Path $Path -Name "DisableSettingSyncUserOverride" -PropertyType Dword -Value 1 -Force


<# Windows Security and Privacy through Registry #>
Write-Host "Adjusting Windows Security and Privacy through Registry" -ForegroundColor Green
# Root Certificate Updates
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableRootAutoUpdate" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "EnableDisallowedCertAutoUpdate" -PropertyType Dword -Value 0 -Force
# Telemetry (Security) / Opt-in Notification
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowTelemetry" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "DisableTelemetryOptInChangeNotification" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowTelemetry" -PropertyType Dword -Value 0 -Force
# Camera
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Camera"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowCamera" -PropertyType Dword -Value 0 -Force
# Camera on Lockscreen
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoLockScreenCamera" -PropertyType Dword -Value 1 -Force
# Application Compatibility
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AITEnable" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "DisableEngine" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "DisablePCA" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "DisablePcaUI" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "DisableInventory" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "SbEnable" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "DisableUAR" -PropertyType Dword -Value 1 -Force
# Disable Automatic Online Activation / Validation Telemetry
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\Activation"; if(-not (Test-Path -LiteralPath $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Manual" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NotificationDisabled" -PropertyType Dword -Value 1 -Force
# Bluetooth Marketing Advertising
$Path = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Bluetooth"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowAdvertising" -PropertyType Dword -Value 0 -Force
# Windows Help Experience Improvement Program
$Path = "HKU:\Software\Policies\Microsoft\Assistance"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKU:\Software\Policies\Microsoft\Assistance\Client"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKU:\Software\Policies\Microsoft\Assistance\Client\1.0"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoImplicitFeedback" -PropertyType Dword -Value 1 -Force
# Peer to Peer services
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Peernet"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Disabled" -PropertyType Dword -Value 1 -Force
# CEIP
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "CEIPEnable" -PropertyType Dword -Value 0 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\SQMClient\Windows"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "CEIPEnable" -PropertyType Dword -Value 0 -Force
# Windows Update
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableWindowsUpdateAccess" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ExcludeWUDriversInQualityUpdate" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoAutoUpdate" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "AUOptions" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "UseWUServer" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "NoAutoRebootWithLoggedOnUsers" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\MRT"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DontOfferThroughWUAU" -PropertyType Dword -Value 1 -Force
# Windows Store
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AutoDownload" -PropertyType Dword -Value 2 -Force
# Delivery Optimization
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DODownloadMode" -PropertyType Dword -Value 100 -Force
# Device/Vendor Metadata
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "PreventDeviceMetadataFromNetwork" -PropertyType Dword -Value 1 -Force
# Text/Ink Data Collection
$Path = "HKU:\Software\Microsoft\InputPersonalization"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "RestrictImplicitInkCollection" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "RestrictImplicitTextCollection" -PropertyType Dword -Value 1 -Force
$Path = "HKU:\Software\Microsoft\InputPersonalization\TrainedDataStore"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HarvestContacts" -PropertyType Dword -Value 0 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowLinguisticDataCollection" -PropertyType Dword -Value 0 -Force
$Path = "HKU:\Software\Microsoft\Input\TIPC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Enabled" -PropertyType Dword -Value 0 -Force
$Path = "HKU:\Software\Microsoft\Personalization\Settings"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AcceptedPrivacyPolicy" -PropertyType Dword -Value 0 -Force
# Clipboard History
$Path = "HKLM:\Software\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowClipboardHistory" -PropertyType Dword -Value 0 -Force
# Settings Pane Online Tips/Help
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowOnlineTips" -PropertyType Dword -Value 0 -Force
# Windows Ask Feedback
$Path = "HKU:\Software\Microsoft\Siuf"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKU:\Software\Microsoft\Siuf\Rules"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NumberOfSIUFInPeriod" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "PeriodInNanoSeconds" -PropertyType Dword -Value 0 -Force
# Track Programs/Documents
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Start_TrackProgs" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "Start_TrackDocs" -PropertyType Dword -Value 0 -Force
# Website Access of Language List
$Path = "HKU:\Control Panel\International\User Profile"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HttpAcceptLanguageOptOut" -PropertyType Dword -Value 1 -Force
# Startmenu/Taskbar Tracking
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoInstrumentation" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NoRecentDocsHistory" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ClearRecentDocsOnExit" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoRecentDocsHistory" -PropertyType Dword -Value 1 -Force
# Login Screen Password Reveal
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredUI"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisablePasswordReveal" -PropertyType Dword -Value 1 -Force
# Content Delivery Manager
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "SilentInstalledAppsEnabled" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "SystemPaneSuggestionsEnabled" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "SoftLandingEnabled" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "ContentDeliveryAllowed" -PropertyType Dword -Value 0 -Force
# Typing Insights
$Path = "HKU:\Software\Microsoft\Input\Settings"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "InsightsEnabled" -PropertyType Dword -Value 0 -Force
# PerfTrack
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WDI"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ScenarioExecutionEnabled" -PropertyType Dword -Value 0 -Force
# Online Front Provider
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableFontProviders" -PropertyType Dword -Value 0 -Force
# Speech Model Update through BITS
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Speech"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllowSpeechModelUpdate" -PropertyType Dword -Value 0 -Force
# KMS Client Online AVS Validation
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoGenTicket" -PropertyType Dword -Value 1 -Force
# Adobe Type Manager Font Driver (ATMFD)
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableATMFD" -PropertyType Dword -Value 1 -Force
# Tailored Experiences Diagnostic Data
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Privacy"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "TailoredExperiencesWithDiagnosticDataEnabled" -PropertyType Dword -Value 0 -Force
# Automatic Sign-in after restart
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableAutomaticRestartSignOn" -PropertyType Dword -Value 1 -Force
# Microsoft Accounts Allowance
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoConnectedUser" -PropertyType Dword -Value 3 -Force
# UWP App Privacy except Microphone (Capability Access Manager)
$Permissions = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore' -Recurse -Depth 1 | Where-Object { $_.PSChildName -NotLike 'microphone'}
ForEach ($item in $Permissions) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'Value' -Value "Deny" -Force }


<# Remove Context Menu Handlers #>
Write-Host "Removing Context Menu Handlers" -ForegroundColor Green
$Path = "HKLM:\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\EPP"; if(Test-Path -LiteralPath $Path){
    # Windows Defender
    Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\EPP"
    Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\EPP"
    Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\EPP"
    # Cast to Device
    $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" -PropertyType String -Value "" -Force
    # Edit with Paint 3D / Rotate Image / 3D Print
    $Context = Get-ChildItem -Path 'HKCR:\SystemFileAssociations' -Recurse -Depth 4 | Where-Object { $_.PSChildName }
    ForEach ($item in $Context) { $path = $item -replace "HKEY_CLASSES_ROOT","HKCR:"; Remove-Item -Path $path -Include '3D Edit','ShellImagePreview','3D Print' -Recurse -Force -Confirm:$False }
    # Give Access To
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Directory\shellex\CopyHookHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Drive\shellex\PropertySheetHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" -Recurse:$True -Confirm:$False
    # Include in Library
    Remove-Item -LiteralPath "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Recurse:$True -Confirm:$False
    # Modern Sharing
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -Recurse:$True -Confirm:$False
    # New Contact
    Remove-Item -LiteralPath "HKCR:\.contact\ShellNew" -Recurse:$True -Confirm:$False
    # Pin Quick Access
    Remove-Item -LiteralPath "HKCR:\Folder\shell\pintohome" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKLM:\SOFTWARE\Classes\Folder\shell\pintohome" -Recurse:$True -Confirm:$False
    # Pin to Start
    Remove-Item -LiteralPath "HKCR:\Folder\shellex\ContextMenuHandlers\PintoStartScreen" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\exefile\shellex\ContextMenuHandlers\PintoStartScreen" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" -Recurse:$True -Confirm:$False
    # Troubleshoot
    $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "{1d27f844-3a1f-4410-85ac-14651078412d}" -PropertyType String -Value "" -Force
    Remove-Item -LiteralPath "HKCR:\lnkfile\shellex\ContextMenuHandlers\Compatibility" -Recurse:$True -Confirm:$False
    # Send To
    Remove-Item -LiteralPath "HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" -Recurse:$True -Confirm:$False
    Remove-Item -LiteralPath "HKCR:\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo" -Recurse:$True -Confirm:$False
}


<# Remove Sound Scheme #>
Write-Host "Removing Sound Scheme" -ForegroundColor Green
$sid = $strSID.Value
$SoundScheme = Get-ChildItem -Path 'HKU:\AppEvents\Schemes\Apps' -Recurse -Depth 3 | Where-Object { $_.PSChildName }
ForEach ($item in $SoundScheme) { $path = $item -replace [regex]::Escape("HKEY_USERS\$sid"),"HKU:"; Set-ItemProperty -LiteralPath $path -Name '(Default)' -Value "" -Force }


<# General Windows Configuration #>
Write-Host "Setting General Windows Configuration through Registry" -ForegroundColor Green
# NTP Timeserver
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NtpServer" -PropertyType String -Value "0.pool.ntp.org,0x9" -Force
# Region Settings
$Path = "HKU:\Control Panel\International"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "sShortDate" -PropertyType String -Value "dd-MMM-yy" -Force
New-ItemProperty -Path $Path -Name "sShortTime" -PropertyType String -Value "HH:mm" -Force
New-ItemProperty -Path $Path -Name "sTimeFormat" -PropertyType String -Value "HH:mm:ss" -Force
New-ItemProperty -Path $Path -Name "iFirstDayOfWeek" -PropertyType String -Value "0" -Force
# Verbose Boot/Reboot Messages
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "VerboseStatus" -PropertyType Dword -Value 1 -Force
# Use Only Latest CLR (NET)
$Path = "HKLM:\SOFTWARE\Microsoft\.NETFramework"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "OnlyUseLatestCLR" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "OnlyUseLatestCLR" -PropertyType Dword -Value 1 -Force
# Show BSOD instead of smiley
$Path = "HKLM:\System\CurrentControlSet\Control\CrashControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisplayParameters" -PropertyType Dword -Value 1 -Force
# Disable Automatic Crash Debugging
Remove-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AeDebug" -Force -Recurse -Confirm:$False
# Network Icon on logon screen
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DontDisplayNetworkSelectionUI" -PropertyType Dword -Value 1 -Force
# Low Disk Space Checks
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoLowDiskSpaceChecks" -PropertyType Dword -Value 1 -Force
# Shutdown Button without Login
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "shutdownwithoutlogon" -PropertyType Dword -Value 1 -Force
# Recently Added Apps in Start Menu
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HideRecentlyAddedApps" -PropertyType Dword -Value 1 -Force
# Auto Restart after BSOD
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AutoReboot" -PropertyType Dword -Value 0 -Force
# Classic Volume Mixer
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableMtcUvc" -PropertyType Dword -Value 0 -Force
# Chkdsk 10 second timeout.
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AutoChkTimeout" -PropertyType Dword -Value 10 -Force
# Hide Fonts Based on Language Settings
$Path = "HKU:\Software\Microsoft\Windows NT\CurrentVersion\Font Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Auto Activation Mode" -PropertyType Dword -Value 1 -Force
# Click-once to Login
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoLockScreen" -PropertyType Dword -Value 1 -Force
# Disable Crash Dumps
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "CrashDumpEnabled" -PropertyType Dword -Value 0 -Force
# Explorer Icon Cache Size
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Max Cached Icons" -PropertyType String -Value "8192" -Force
# Disable Windows Keys
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x5B,0xE0,0x00,0x00,0x5C,0xE0,0x0)) -Force
# Disable Language Switch Hotkeys
$Path = "HKU:\Keyboard Layout\Toggle"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Language Hotkey" -PropertyType String -Value "3" -Force
New-ItemProperty -Path $Path -Name "Hotkey" -PropertyType String -Value "3" -Force
New-ItemProperty -Path $Path -Name "Layout Hotkey" -PropertyType String -Value "3" -Force
# Disable Sticky/Filter/Toggle Hotkeys
$Path = "HKU:\Control Panel\Accessibility\StickyKeys"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Flags" -PropertyType String -Value "506" -Force
$Path = "HKU:\Control Panel\Accessibility\Keyboard Response"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Flags" -PropertyType String -Value "122" -Force
$Path = "HKU:\Control Panel\Accessibility\ToggleKeys"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Flags" -PropertyType String -Value "58" -Force
# Disable F1 Help Key
$Path = "HKU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win32"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path -Force}
New-ItemProperty -Path $Path -Name "(Default)" -PropertyType String -Value "" -Force
$Path = "HKU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path -Force}
New-ItemProperty -Path $Path -Name "(Default)" -PropertyType String -Value "" -Force
# Disable Network Location Wizard
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NetworkLocationWizard"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HideWizard" -PropertyType Dword -Value 1 -Force
# Disable New Network Location Window
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
# Disable Automatic Setup of Network Connected Devices
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AutoSetup" -PropertyType Dword -Value 0 -Force
# Don't Notify When Clock Changes
$Path = "HKU:\Control Panel\TimeDate"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DstNotification" -PropertyType Dword -Value 0 -Force
# Hide/Show Disabled/Disconnected Audio Devices
$Path = "HKU:\Software\Microsoft\Multimedia\Audio\DeviceCpl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowHiddenDevices" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "ShowDisconnectedDevices" -PropertyType Dword -Value 1 -Force
# Disable Windows Detects Communications Activity
$Path = "HKU:\Software\Microsoft\Multimedia\Audio"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "UserDuckingPreference" -PropertyType Dword -Value 3 -Force
# Disable Modern Push Notifications
$Path = "HKU:\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoToastApplicationNotification" -PropertyType Dword -Value 1 -Force
# Disable Spelling/Typing Related Aid.
$Path = "HKU:\Software\Microsoft\TabletTip\1.7"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableAutocorrection" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnableSpellchecking" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnableTextPrediction" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnablePredictionSpaceInsertion" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnableDoubleTapSpace" -PropertyType Dword -Value 0 -Force
# GameBar/GameDVR Related
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"; New-ItemProperty -Name AllowGameDVR -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" -Name ActivationType -PropertyType Dword -Value 0 -Force
$Path = "HKU:\SOFTWARE\Microsoft\GameBar"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "UseNexusForGameBarEnabled" -PropertyType Dword -Value 0 -Force
$Path = "HKU:\System\GameConfigStore"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "GameDVR_Enabled" -PropertyType Dword -Value 0 -Force
# Enable/Disable Full Screen Optimizations (All to 0 is On)
#$Path = "HKU:\System\GameConfigStore"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -PropertyType Dword -Value 1 -Force
#New-ItemProperty -Path $Path -Name "GameDVR_EFSEFeatureFlags" -PropertyType Dword -Value 0 -Force
#New-ItemProperty -Path $Path -Name "GameDVR_FSEBehavior" -PropertyType Dword -Value 2 -Force
#New-ItemProperty -Path $Path -Name "GameDVR_FSEBehaviorMode" -PropertyType Dword -Value 2 -Force
#New-ItemProperty -Path $Path -Name "GameDVR_HonorUserFSEBehaviorMode" -PropertyType Dword -Value 1 -Force
# Game Mode On/Off
#$Path = "HKU:\Software\Microsoft\GameBar"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "AutoGameModeEnabled" -PropertyType Dword -Value 0 -Force

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    # Disable Windows Keys, and remap key close to left shift (to left shift)
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x2a,0x00,0x56,0x00,0x00,0x00,0x5b,0xe0,0x00,0x00,0x5c,0xe0,0x00,0x00,0x00,0x00)) -Force
    # Precision Touchpad Configuration
    $Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "AAPThreshold" -PropertyType Dword -Value 3 -Force
    New-ItemProperty -Path $Path -Name "CursorSpeed" -PropertyType Dword -Value 12 -Force
    New-ItemProperty -Path $Path -Name "EnableEdgy" -PropertyType Dword -Value -1 -Force
    New-ItemProperty -Path $Path -Name "LeaveOnWithMouse" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "PanEnabled" -PropertyType Dword -Value -1 -Force
    New-ItemProperty -Path $Path -Name "RightClickZoneEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "ScrollDirection" -PropertyType Dword -Value -1 -Force
    New-ItemProperty -Path $Path -Name "TapAndDrag" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "TapsEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "TwoFingerTapEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "ZoomEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "UsePhysicalMonitorDpi" -PropertyType Dword -Value -1 -Force
    New-ItemProperty -Path $Path -Name "HonorMouseAccelSetting" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "ThreeFingerSlideEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "ThreeFingerTapEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "FourFingerSlideEnabled" -PropertyType Dword -Value 0 -Force
    New-ItemProperty -Path $Path -Name "FourFingerTapEnabled" -PropertyType Dword -Value 0 -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    # Secure Logon (Ctrl+alt+del)
    $Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableCAD" -PropertyType Dword -Value 0 -Force   
    }


<# Explorer/Desktop Related Configuration #>
Write-Host "Set Explorer Configuration" -ForegroundColor Green
# More Details in File Operation Dialog
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnthusiastMode" -PropertyType Dword -Value 1 -Force
# Show Windows Version on Desktop
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "PaintDesktopVersion" -PropertyType Dword -Value 1 -Force
# Low Risk File Types
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "LowRiskFileTypes" -PropertyType String -Value '.avi;.bat;.cmd;.exe;.htm;.html;.lnk;.mpg;.mpeg;.mov;.mp3;.mp4;.mkv;.msi;.m3u;.rar;.reg;.txt;.vbs;.wav;.zip;.7z;.msu' -Force
# Taskbar Grouping
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoTaskGrouping" -PropertyType Dword -Value 1 -Force
# Mouse Mouse Vertical Scrollwheel Steps
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "WheelScrollLines" -PropertyType String -Value "10" -Force
# Always Show Mouse Cursor
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableCursorSurpression" -PropertyType Dword -Value 0 -Force
# Maximize Context Menu Handlers
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "MultipleInvokePromptMinimum" -PropertyType Dword -Value 100 -Force
# Legacy Balloon Notifications
$Path = "HKU:\Software\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableLegacyBalloonNotifications" -PropertyType Dword -Value 1 -Force
# Search whole filesystem instead of using Index
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "WholeFileSystem" -PropertyType Dword -Value 1 -Force
# Open Explorer in 'This PC'
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "LaunchTo" -PropertyType Dword -Value 1 -Force
# Disable Expand to Current Folder
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NavPaneExpandToCurrentFolder" -PropertyType Dword -Value 0 -Force
# Disable Explorer Search History
$Path = "HKU:\Software\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableSearchBoxSuggestions" -PropertyType Dword -Value 1 -Force
# Disable Sharing Wizard
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "SharingWizardOn" -PropertyType Dword -Value 0 -Force
# Hide Folder Merge Conflicts
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HideMergeConflicts" -PropertyType Dword -Value 1 -Force
# Explorer Show Full Path
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Settings" -PropertyType Binary -Value ([byte[]](0x0c,0x00,0x02,0x00,0x0b,0x01,0x00,0x00,0x60,0x00,0x00,0x00)) -Force
New-ItemProperty -Path $Path -Name "FullPath" -PropertyType Dword -Value 1 -Force
# Disable Aero Shake
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisallowShaking" -PropertyType Dword -Value 1 -Force
# Disable Aero Snap Assist
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "SnapAssist" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "JointResize" -PropertyType Dword -Value 0 -Force
# Maximum Wallpaper JPEG Quality
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "JPEGImportQuality" -PropertyType Dword -Value 999 -Force
# No File Delete Notification
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ConfirmFileDelete" -PropertyType Dword -Value 0 -Force
# Always Desktop-Mode
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "TabletMode" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "SignInMode" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ConvertibleSlateModePromptPreference" -PropertyType Dword -Value 2 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "TaskbarAutoHideInTabletMode" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "TaskbarAppsVisibleInTabletMode" -PropertyType Dword -Value 1 -Force
# Unhide Known File Extensions
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HideFileExt" -PropertyType Dword -Value 0 -Force
# Show (Super) Hidden Files
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Hidden" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ShowSuperHidden" -PropertyType Dword -Value 1 -Force
# Show NTFS Encrypt/Compression Colors
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowEncryptCompressedColor" -PropertyType Dword -Value 1 -Force
# UWP Disable Dynamic Scrollbars
$Path = "HKU:\Control Panel\Accessibility"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DynamicScrollbars" -PropertyType Dword -Value 0 -Force
# Change Application Start/Shutdown Delay
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "StartupDelayInMSec" -PropertyType Dword -Value 1872 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shutdown\Serialize"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "StartupDelayInMSec" -PropertyType Dword -Value 0 -Force
# Show/Hide Status Bar
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowStatusBar" -PropertyType Dword -Value 0 -Force
# Show Empty Drives
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HideDrivesWithNoMedia" -PropertyType Dword -Value 0 -Force
# Show/Hide Explorer Menus
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AlwaysShowMenus" -PropertyType Dword -Value 0 -Force
# Disable Search the Microsoft Store
$Path = "HKLM:\Software\Policies\Microsoft\Windows\Explo‌​rer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoUseStoreOpenWith" -PropertyType DWord -Value 1 -Force
# Explorer Thumbnail Cache
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoThumbnailCache" -PropertyType Dword -Value 1 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableThumbnailCache" -PropertyType Dword -Value 1 -Force
# No New App Alert
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoNewAppAlert" -PropertyType Dword -Value 1 -Force
# Disable Touch Screen Gestures
$Path = "HKU:\Control Panel\Cursors"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ContactVisualization" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "GestureVisualization" -PropertyType Dword -Value 0 -Force
# Control Panel Classic View
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AllItemsIconView" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "StartupPage" -PropertyType Dword -Value 1 -Force
# Disable Network Drive Mapping icon error in tray
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "RestoreConnection" -PropertyType Dword -Value 0 -Force
# Disable Explorer Quick Access
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HubMode" -PropertyType Dword -Value 1 -Force
# Disable Themes Ability to Change Sounds, Wallpapers, Icons, etc.
$Path = "HKU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ThemeChangesDesktopIcons" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "ThemeChangesMousePointers" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "ColorSetFromTheme" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "WallpaperSetFromTheme" -PropertyType Dword -Value 0 -Force
$Path = "HKU:\Software\Policies\Microsoft\Windows\Personalization"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoChangingSoundScheme" -PropertyType Dword -Value 1 -Force
# Explorer Animation / Shortcut Resolve Speed
$Path = "HKU:\Control Panel\Mouse"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "MouseHoverTime" -PropertyType String -Value "1" -Force
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "MenuShowDelay" -PropertyType String -Value "1" -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "LinkResolveIgnoreLinkInfo" -PropertyType Dword -Value "1" -Force
New-ItemProperty -Path $Path -Name "NoResolveSearch" -PropertyType Dword -Value "1" -Force
New-ItemProperty -Path $Path -Name "NoResolveTrack" -PropertyType Dword -Value "1" -Force
# Clean-up Explorer Namespaces
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Force -Recurse -Confirm:$False
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Force -Recurse -Confirm:$False
# Clean-up Control Panel
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisallowCPL" -PropertyType Dword -Value 1 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowCpl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "1" -PropertyType String -Value "AutoPlay" -Force
New-ItemProperty -Path $Path -Name "2" -PropertyType String -Value "Internet Options" -Force
New-ItemProperty -Path $Path -Name "3" -PropertyType String -Value "RemoteApp and Desktop Connections" -Force
New-ItemProperty -Path $Path -Name "4" -PropertyType String -Value "Speech Recognition" -Force
New-ItemProperty -Path $Path -Name "5" -PropertyType String -Value "Phone and Modem" -Force
New-ItemProperty -Path $Path -Name "6" -PropertyType String -Value "Recovery" -Force
New-ItemProperty -Path $Path -Name "7" -PropertyType String -Value "Backup and Restore (Windows 7)" -Force
New-ItemProperty -Path $Path -Name "8" -PropertyType String -Value "Ease of Access Center" -Force
New-ItemProperty -Path $Path -Name "9" -PropertyType String -Value "File History" -Force
New-ItemProperty -Path $Path -Name "10" -PropertyType String -Value "Flash Player" -Force
New-ItemProperty -Path $Path -Name "11" -PropertyType String -Value "Infrared" -Force
New-ItemProperty -Path $Path -Name "12" -PropertyType String -Value "Security and Maintenance" -Force
New-ItemProperty -Path $Path -Name "13" -PropertyType String -Value "Storage Spaces" -Force
New-ItemProperty -Path $Path -Name "14" -PropertyType String -Value "Sync Center" -Force
New-ItemProperty -Path $Path -Name "15" -PropertyType String -Value "Troubleshooting" -Force
New-ItemProperty -Path $Path -Name "16" -PropertyType String -Value "Windows To Go" -Force
New-ItemProperty -Path $Path -Name "17" -PropertyType String -Value "Taskbar and Navigation" -Force
New-ItemProperty -Path $Path -Name "18" -PropertyType String -Value "Indexing Options" -Force
New-ItemProperty -Path $Path -Name "19" -PropertyType String -Value "Keyboard" -Force
# Show Default Desktop Icons
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path -Force -Confirm:$False }
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path -Force -Confirm:$False }
New-ItemProperty -Path $Path -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -PropertyType Dword -Value 0 -Force
# Default Windows 2000 Background Color
$Path = "HKU:\Control Panel\Colors"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path -Force -Confirm:$False }
New-ItemProperty -Path $Path -Name "Background" -PropertyType String -Value "58 110 165" -Force
# Accent Color
#$Path = "HKU:\Software\Microsoft\Windows\DWM"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path "$Path" -Name "AccentColor" -Value -12566722 -PropertyType DWord -Force
#$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path "$Path" -Name "AccentPalette" -Value ([byte[]](0x69,0x6b,0x6c,0xff,0x57,0x59,0x5a,0xff,0x4b,0x4c,0x4d,0xff,0x3e,0x3f,0x40,0xff,0x32,0x33,0x33,0xff,0x25,0x26,0x26,0xff,0x14,0x14,0x14,0xff,0x88,0x17,0x98,0x00)) -PropertyType Binary -Force
#$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path "$Path" -Name "StartColorMenu" -Value -13421774 -PropertyType Dword -Force
#$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path "$Path" -Name "AccentColorMenu" -Value -12566722 -PropertyType Dword -Force
# Font Smoothing
#$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "FontSmoothing" -PropertyType String -Value "2" -Force
#New-ItemProperty -Path $Path -Name "FontSmoothingOrientation" -PropertyType Dword -Value 1 -Force
#New-ItemProperty -Path $Path -Name "FontSmoothingType" -PropertyType Dword -Value 2 -Force
# Custom (Optimized) Visual Settings
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "VisualFXSetting" -PropertyType Dword -Value 3 -Force
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path "$Path" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x07,0x80,0x10,0x00,0x00,0x00)) -PropertyType Binary -Force
New-ItemProperty -Path "$Path" -Name "DragFullWindows" -Value "1" -PropertyType String -Force
New-ItemProperty -Path "$Path" -Name "FontSmoothing" -Value "2" -PropertyType String -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path "$Path" -Name "ListviewShadow" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "ListviewAlphaSelect" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "IconsOnly" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "TaskbarAnimations" -Value 0 -PropertyType DWord -Force
$Path = "HKU:\Software\Microsoft\Windows\DWM"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path "$Path" -Name "EnableAeroPeek" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "AlwaysHibernateThumbnails" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "ColorPrevalence" -Value 0 -PropertyType DWord -Force
$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path "$Path" -Name "MinAnimate" -Value "0" -PropertyType String -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path "$Path" -Name "AppsUseLightTheme" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "EnableTransparency" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "$Path" -Name "ColorPrevalence" -Value 0 -PropertyType DWord -Force
# Desktop Icon Spacing (Before further tweaking)
$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "IconVerticalSpacing" -PropertyType String -Value "-1100" -Force
New-ItemProperty -Path $Path -Name "IconSpacing" -PropertyType String -Value "-1225" -Force

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    # No Lockscreen Wallpaper
    $Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableLogonBackgroundImage" -PropertyType DWord -Value 1 -Force
    # Adjust Font Gamma
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "FontSmoothingGamma" -PropertyType Dword -Value 1600 -Force
    # Custom (Optimized) Visual Settings with Cursor Shadow Enabled.
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x32,0x07,0x80,0x10,0x00,0x00,0x00)) -PropertyType Binary -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    # No Lockscreen Wallpaper
    $Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableLogonBackgroundImage" -PropertyType DWord -Value 1 -Force
    # (Low) Visual Settings
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -PropertyType Binary -Force
    New-ItemProperty -Path "$Path" -Name "DragFullWindows" -Value "1" -PropertyType String -Force
    New-ItemProperty -Path "$Path" -Name "FontSmoothing" -Value "2" -PropertyType String -Force
    $Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "ListviewShadow" -Value 0 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "ListviewAlphaSelect" -Value 1 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "IconsOnly" -Value 1 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "TaskbarAnimations" -Value 0 -PropertyType DWord -Force
    $Path = "HKU:\Software\Microsoft\Windows\DWM"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "EnableAeroPeek" -Value 0 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "AlwaysHibernateThumbnails" -Value 0 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "ColorPrevalence" -Value 0 -PropertyType DWord -Force
    $Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "MinAnimate" -Value "0" -PropertyType String -Force
    $Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path "$Path" -Name "AppsUseLightTheme" -Value 1 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "EnableTransparency" -Value 0 -PropertyType DWord -Force
    New-ItemProperty -Path "$Path" -Name "ColorPrevalence" -Value 0 -PropertyType DWord -Force
    }


<# Configure DPI / Text Scaling + Mouse 1:1 Movement #>
Write-Host "Configure DPI Preferences" -ForegroundColor Green
# Windows 8 (Custom DPI) Scaling
$Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Win8DpiScaling" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "DpiScalingVer" -PropertyType Dword -Value 4096 -Force
# High DPI Aware Executables
$Path = "HKU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "C:\Windows\System32\mmc.exe" -PropertyType String -Value "~ HIGHDPIAWARE" -Force
New-ItemProperty -Path $Path -Name "C:\Windows\System32\msiexec.exe" -PropertyType String -Value "~ HIGHDPIAWARE" -Force
New-ItemProperty -Path $Path -Name "C:\Windows\System32\perfmon.exe" -PropertyType String -Value "~ HIGHDPIAWARE" -Force
# We always want to dictate custom DPI % even at common values i.e. 100%/125%/150%. This solves some issues with window locations / blurry taskbar icons after resolution change / alt+tab
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    # Custom DPI
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "LogPixels" -PropertyType Dword -Value 110 -Force
    # Change Title Bar Height
    #$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "CaptionHeight" -PropertyType String -Value "-300" -Force
    # Change Horizontal/Vertical Scrollbar Size
    #$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "ScrollHeight" -PropertyType String -Value "-200" -Force
    #New-ItemProperty -Path $Path -Name "ScrollWidth" -PropertyType String -Value "-200" -Force
    # Desktop Icon Spacing
    $Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "IconVerticalSpacing" -PropertyType String -Value "-1200" -Force
    New-ItemProperty -Path $Path -Name "IconSpacing" -PropertyType String -Value "-1400" -Force
    # 'Make Text Bigger' (Increase)
    #$Path = "HKU:\Software\Microsoft\Accessibility"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "TextScaleFactor" -PropertyType Dword -Value 109 -Force
    # Linear Mouse Movement 1:1 based on above DPI setting)
    $Path = "HKU:\Control Panel\Mouse"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "SmoothMouseXCurve" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xA0,0xAA,0x0E,0x00,0x00,0x00,0x00,0x00,0x40,0x55,0x1D,0x00,0x00,0x00,0x00,0x00,0xE0,0xFF,0x2B,0x00,0x00,0x00,0x00,0x00,0x80,0xAA,0x3A,0x00,0x00,0x00,0x00,0x00)) -Force
    New-ItemProperty -Path $Path -Name "SmoothMouseYCurve" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x38,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x70,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xA8,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xE0,0x00,0x00,0x00,0x00,0x00)) -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    # Custom DPI 150%
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "LogPixels" -PropertyType Dword -Value 144 -Force
    # Change Title Bar Height
    #$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "CaptionHeight" -PropertyType String -Value "-315" -Force
    # Change Horizontal/Vertical Scrollbar Size
    #$Path = "HKU:\Control Panel\Desktop\WindowMetrics"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "ScrollHeight" -PropertyType String -Value "-215" -Force
    #New-ItemProperty -Path $Path -Name "ScrollWidth" -PropertyType String -Value "-215" -Force
    # Disable Enhance Mouse Pointer
    $Path = "HKU:\Control Panel\Mouse"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "MouseSpeed" -PropertyType String -Value "0" -Force
    New-ItemProperty -Path $Path -Name "MouseThreshold1" -PropertyType String -Value "0" -Force
    New-ItemProperty -Path $Path -Name "MouseThreshold2" -PropertyType String -Value "0" -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    # Custom DPI 100%
    $Path = "HKU:\Control Panel\Desktop"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "LogPixels" -PropertyType Dword -Value 96 -Force
    # Disable Enhance Mouse Pointer
    $Path = "HKU:\Control Panel\Mouse"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "MouseSpeed" -PropertyType String -Value "0" -Force
    New-ItemProperty -Path $Path -Name "MouseThreshold1" -PropertyType String -Value "0" -Force
    New-ItemProperty -Path $Path -Name "MouseThreshold2" -PropertyType String -Value "0" -Force
    }
 

<# Low-level Configuration #>
Write-Host "Set Low-level Configuration" -ForegroundColor Green
# Global Application Security Exploit Mitigations (Disable all potential performance impairing exploit mitigations, except DEP, required for VAC)
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "MitigationOptions" -PropertyType Binary -Value ([byte[]](0x21,0x22,0x22,0x00,0x20,0x02,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00)) -Force
# Per-Application Specific Mitigations
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe"; if(-not (Test-Path -LiteralPath $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -LiteralPath $Path -Name "MitigationOptions" -PropertyType Binary -Value ([byte[]](0x11,0x11,0x11,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00)) -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\mstsc.exe"; if(-not (Test-Path -LiteralPath $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -LiteralPath $Path -Name "MitigationOptions" -PropertyType Binary -Value ([byte[]](0x11,0x11,0x11,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00)) -Force
# Disable Spectre/Meltdown Mitigation
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "FeatureSettingsOverride" -PropertyType Dword -Value 3 -Force
New-ItemProperty -Path $Path -Name "FeatureSettingsOverrideMask" -PropertyType Dword -Value 3 -Force
# Enable Intel TSX
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisableTsx" -PropertyType Dword -Value 0 -Force
# UWP Swap File
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "SwapfileControl" -PropertyType Dword -Value 0 -Force
# NTFS
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NtfsDisable8dot3NameCreation" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NtfsDisableLastAccessUpdate" -PropertyType Dword -Value -2147483647 -Force
New-ItemProperty -Path $Path -Name "LongPathsEnabled" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NtfsDisableCompression" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NtfsEncryptPagingFile" -PropertyType Dword -Value 1 -Force
# MMCSS
#$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "SystemResponsiveness" -PropertyType Dword -Value 10 -Force
#New-ItemProperty -Path $Path -Name "NetworkThrottlingIndex" -PropertyType Dword -Value 10 -Force
#$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Scheduling Category" -PropertyType String -Value 'High' -Force
#New-ItemProperty -Path $Path -Name "Priority" -PropertyType Dword -Value 1 -Force
#$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Scheduling Category" -PropertyType String -Value 'High' -Force
#New-ItemProperty -Path $Path -Name "Priority" -PropertyType Dword -Value 4 -Force
#$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Scheduling Category" -PropertyType String -Value 'Medium' -Force
#New-ItemProperty -Path $Path -Name "Priority" -PropertyType Dword -Value 8 -Force

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') { 
    Disable-MMAgent -MemoryCompression -PageCombining
    #Set-MMAgent -MaxOperationAPIFiles 1024
    Enable-MMAgent -ApplicationPreLaunch
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Win32PrioritySeparation" -PropertyType Dword -Value 38 -Force
    #$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "DisablePagingExecutive" -PropertyType Dword -Value 1 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "PagingFiles" -PropertyType MultiString -Value @("c:\pagefile.sys 16384 16384") -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    Disable-MMAgent -MemoryCompression -PageCombining
    #Set-MMAgent -MaxOperationAPIFiles 1024
    Enable-MMAgent -ApplicationPreLaunch
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Win32PrioritySeparation" -PropertyType Dword -Value 38 -Force
    #$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    #New-ItemProperty -Path $Path -Name "DisablePagingExecutive" -PropertyType Dword -Value 1 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "PagingFiles" -PropertyType MultiString -Value @("c:\pagefile.sys 16384 16384") -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    Disable-MMAgent -ApplicationPreLaunch
    Enable-MMAgent -MemoryCompression -PageCombining
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "Win32PrioritySeparation" -PropertyType Dword -Value 24 -Force
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "PagingFiles" -PropertyType MultiString -Value @("c:\pagefile.sys 16384 16384") -Force
    }


<# Power Management #>
Write-Host "Set Power Management Configuration" -ForegroundColor Green
$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "PowerdownAfterShutdown" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Power"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HiberFileSizePercent" -PropertyType Dword -Value 100 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Power"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HiberFileType" -PropertyType Dword -Value 3 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowHibernateOption" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "ShowLockOption" -PropertyType Dword -Value 1 -Force
# Fast Startup
$Path = "HKLM:\System\CurrentControlSet\Control\Session Manager\Power"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "HiberbootEnabled" -PropertyType Dword -Value 0 -Force
# Connected Standby
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Power"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "CsEnabled" -PropertyType Dword -Value 0 -Force
# Apps in Background
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "GlobalUserDisabled" -PropertyType Dword -Value 1 -Force
$Path = "HKU:\Software\Microsoft\Windows\CurrentVersion\Search"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "BackgroundAppGlobalToggle" -PropertyType Dword -Value 0 -Force
# Expose all unhidden power plan options
$PowerSettings = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings' -Recurse -Depth 1 | Where-Object { $_.PSChildName -NotLike 'DefaultPowerSchemeValues' -and $_.PSChildName -NotLike '0' -and $_.PSChildName -NotLike '1' }
ForEach ($item in $PowerSettings) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'Attributes' -Value 2 -Force }

# Prepare predefined Power Plans, Import and activate Dummy.pow plan for temporary use.
copy .\Pow\*.pow C:\
powercfg /import "c:\Dummy.pow" 90000000-0000-0000-0000-000000000009
powercfg /S 90000000-0000-0000-0000-000000000009

# Remove all default power plans and import desired plans, then activate. (Also apply other system-specific power settings)
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    powercfg /d a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg /d 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /d 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg /d e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /import "c:\Balanced (MS-7B12).pow" 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /import "c:\Ultimate (MS-7B12).pow" e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /S 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /h on
    # Show Seconds in Taskbar Clock
    $Path = "HKU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "ShowSecondsInSystemClock" -PropertyType Dword -Value 1 -Force

    $Path = "HKU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BamThrottling"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableWindowHinting" -PropertyType Dword -Value 1 -Force
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    powercfg /d a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg /d 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /d 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg /d e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /import "c:\Balanced (RZ09-0310).pow" 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /S 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /h on
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    powercfg /d a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg /d 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /d 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg /d e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /import "c:\Balanced (A10N-8800E).pow" 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /S 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg /h off
    $Path = "HKU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BamThrottling"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableWindowHinting" -PropertyType Dword -Value 1 -Force
    }

# If system model undefined, just return to balanced plan
powercfg /S 381b4222-f694-41f0-9685-ff5bb260df2e
# Undo temporary changes, delete dummy profile.
del C:\*.pow
powercfg /d 90000000-0000-0000-0000-000000000009


<# Network General/Protocol Configuration #>
Write-Host "Set General Networking Configuration" -ForegroundColor Green
Set-NetIPinterface -InterfaceAlias '*' -NlMtuBytes 1440
Set-NetTCPSetting -EcnCapability Enable
Set-NetAdapterBinding -Name '*' -DisplayName 'Client for Microsoft Networks' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Internet Protocol Version 6 (TCP/IPv6)' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Microsoft LLDP Protocol Driver' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Link-Layer Topology Discovery Responder' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Link-Layer Topology Discovery Mapper I/O Driver' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'QoS Packet Scheduler' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Hyper-V Extensible Virtual Switch' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Microsoft Network Adapter Multiplexor Protocol' -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Microsoft NDIS Capture' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Microsoft RDMA - NDK' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'NetBIOS Interface' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'NDIS Usermode I/O Protocol' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'Point to Point Protocol Over Ethernet' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'WINS Client(TCP/IP) Protocol' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name '*' -DisplayName 'NDIS Usermode I/O Protocol' -AllBindings -Enabled 0 -ea SilentlyContinue
#VMware Adapter (NAT)
Set-NetAdapterBinding -Name 'VMware Network Adapter VMNet8' -DisplayName 'Client For Microsoft Networks' -AllBindings -Enabled 0 -ea SilentlyContinue
Set-NetAdapterBinding -Name 'VMware Network Adapter VMNet8' -DisplayName 'File and Printer Sharing for Microsoft Networks' -AllBindings -Enabled 0 -ea SilentlyContinue

# Disable Nagle's Algorithm on all interfaces
#$i = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces'  
#Get-ChildItem $i | ForEach-Object {  
#    Set-ItemProperty -Path "$i\$($_.pschildname)" -name TcpAckFrequency -value 1
#    Set-ItemProperty -Path "$i\$($_.pschildname)" -name TCPNoDelay -value 1
#}

# Disable NetBIOS on all interfaces
$i = 'HKLM:\SYSTEM\CurrentControlSet\Services\netbt\Parameters\interfaces'  
Get-ChildItem $i | ForEach-Object {  
    Set-ItemProperty -Path "$i\$($_.pschildname)" -name NetBiosOptions -value 2
}

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableMulticast" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "RegistrationEnabled" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "DisableSmartNameResolution" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoActiveProbe" -PropertyType Dword -Value 1 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableActiveProbing" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "ActiveDnsProbeContent" -PropertyType String -Value "192.168.1.1:8080" -Force
New-ItemProperty -Path $Path -Name "ActiveDnsProbeHost" -PropertyType String -Value "192.168.1.1:8080" -Force
New-ItemProperty -Path $Path -Name "ActiveWebProbeHost" -PropertyType String -Value "192.168.1.1:8080" -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DisabledComponents" -PropertyType Dword -Value 0x00000020 -Force # Prefer ipv4 over ivp6, recommended instead of disabling
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LLTD"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "EnableLLTDIO" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "EnableRspndr" -PropertyType Dword -Value 0 -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TCPIP\v6Transition"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "6to4_State" -PropertyType String -Value "Disabled" -Force
New-ItemProperty -Path $Path -Name "ISATAP_State" -PropertyType String -Value "Disabled" -Force
New-ItemProperty -Path $Path -Name "Teredo_State" -PropertyType String -Value "Disabled" -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\services\Tcpip\QoS"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Do not use NLA" -PropertyType String -Value "1" -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "fMinimizeConnections" -PropertyType Dword -Value "1" -Force
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\HotspotAuthentication"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Enabled" -PropertyType Dword -Value "0" -Force
$Path = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "AutoConnectAllowedOEM" -PropertyType Dword -Value "0" -Force
$Path = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "value" -PropertyType Dword -Value "0" -Force
$Path = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "value" -PropertyType Dword -Value "0" -Force
$Path = "HKLM:\SOFTWARE\Microsoft\WlanSvc\AnqpCache"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "OsuRegistrationStatus" -PropertyType Dword -Value "0" -Force

<# Network Adapter Configuration #>
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'ARP Offload' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Energy Efficient Ethernet' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'DMA Coalescing' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Enable PME' -RegistryValue '0' # 1 Needed for WoL?
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Flow Control' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Interrupt Moderation' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Interrupt Moderation Rate' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'IPv4 Checksum Offload' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Large Send Offload (IPv4)' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Large Send Offload V2 (IPv4)' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Large Send Offload V2 (IPv6)' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Maximum Number of RSS Queues' -RegistryValue '1'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'NS Offload' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Packet Priority & VLAN' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Receive Buffers' -RegistryValue '2048'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Transmit Buffers' -RegistryValue '2048'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Receive Side Scaling' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Reduce Speed On Power Down' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Shutdown Wake Up' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Speed & Duplex' -RegistryValue '6'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'TCP Checksum Offload (IPv4)' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'TCP Checksum Offload (IPv6)' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'UDP Checksum Offload (IPv4)' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'UDP Checksum Offload (IPv6)' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Wake on Magic Packet' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Ethernet*' -DisplayName 'Wake on Pattern Match' -RegistryValue '0'
    #Set-NetOffloadGlobalSetting -ReceiveSideScaling Disabled
    Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Disabled
    Set-NetAdapterRss -Name '*Ethernet*' -Profile 'NUMAStatic' -BaseProcessorNumber 2 -MaxProcessorNumber 6 -NumberOfReceiveQueues 2
    }

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'Global BG Scan blocking' -RegistryValue '2'
    Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'Preferred Band' -RegistryValue '2'
    Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'Roaming Aggressiveness' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName '802.11n/ac/ax Wireless Mode' -RegistryValue '2'
    Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'MIMO Power Save Mode' -RegistryValue '3'
    #Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'U-APSD Support' -RegistryValue '0'
    #Set-NetAdapterAdvancedProperty -Name '*Wi-Fi*' -DisplayName 'Packet Coalescing' -RegistryValue '1'
    #Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Disabled
    #Set-NetOffloadGlobalSetting -ReceiveSideScaling disabled
    }
    
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Energy-Efficient Ethernet' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Flow Control' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Gigabit Lite' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Green Ethernet' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Interrupt Moderation' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Maximum Number of RSS Queues' -RegistryValue '4'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Power Saving Mode' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Priority & VLAN' -RegistryValue '0'
    Set-NetAdapterAdvancedProperty -Name '*' -DisplayName 'Receive Side Scaling' -RegistryValue '1'
    Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing Disabled
    Set-NetOffloadGlobalSetting -ReceiveSideScaling enabled
    Set-NetAdapterRss -Name '*' -Profile 'NUMAStatic' -BaseProcessorNumber 0 -MaxProcessorNumber 3 -NumberOfReceiveQueues 4
    }


<# Configure Firewall #>
Write-Host "Configuring Firewall" -ForegroundColor Green
# Audit Firewall Connection Attempts in Registry
auditpol /set /subcategory:"{0CCE9226-69AE-11D9-BED3-505054503030}" /success:disable /failure:enable
# Make Register-WMIEvent work with 'Microsoft-Windows-Windows Firewall With Advanced Security/Firewall' event log (Required for Auto Purge Task)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventLog\Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" /f
# Global Firewall Config
Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Block -NotifyOnListen False -AllowUnicastResponseToMulticast False
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
& {Get-NetFirewallRule | Where { $_.DisplayName -notmatch 'Allow *' } | Remove-NetFirewallRule;}
Remove-NetFirewallRule -DisplayName 'Script Generated*'
New-NetFirewallRule -Display 'Script Generated: IGMP (IGMP-In)' -Direction Inbound -Protocol 2 -Program 'System' -Action Allow
New-NetFirewallRule -Display 'Script Generated: IGMP (IGMP-Out)' -Direction Outbound -Protocol 2 -Program 'System' -Action Allow
New-NetFirewallRule -Display 'Script Generated: DHCP (DHCP-In)' -Direction Inbound -Protocol UDP -RemotePort 67 -LocalPort 68 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dhcp' -Action Allow
New-NetFirewallRule -Display 'Script Generated: DHCP (DHCP-Out)' -Direction Outbound -Protocol UDP -RemotePort 67 -LocalPort 68 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dhcp' -Action Allow
New-NetFirewallRule -Display 'Script Generated: Ping Fragment Needed (ICMPv4-In)' -Direction Inbound -Protocol ICMPv4 -IcmpType 0 -Action Allow
New-NetFirewallRule -Display 'Script Generated: Ping (ICMPv4-In)' -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
New-NetFirewallRule -Display 'Script Generated: Ping (ICMPv4-Out)' -Direction Outbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-In)' -Direction Inbound -Action Allow -Protocol UDP -RemotePort 5355 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-In)' -Direction Inbound -Action Allow -Protocol UDP -LocalPort 5355 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-In)' -Direction Inbound -Action Allow -Protocol UDP -LocalPort 5353 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-Out)' -Direction Outbound -Action Allow -Protocol UDP -RemotePort 5355 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-Out)' -Direction Outbound -Action Allow -Protocol UDP -LocalPort 5355 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: LLMNR (UDP-Out)' -Direction Outbound -Action Allow -Protocol UDP -RemotePort 5353 -Program 'C:\Windows\System32\svchost.exe' -Service 'Dnscache'
New-NetFirewallRule -Display 'Script Generated: DNS (TCP-Out)' -Direction Outbound -Action Allow -Protocol TCP -RemotePort 53
New-NetFirewallRule -Display 'Script Generated: DNS (UDP-Out)' -Direction Outbound -Action Allow -Protocol UDP -RemotePort 53
New-NetFirewallRule -Display 'Script Generated: SMB (TCP-In)' -Direction Inbound -Protocol TCP -LocalPort 445 -Program 'System' -Action Allow
New-NetFirewallRule -Display 'Script Generated: SMB (TCP-Out)' -Direction Outbound -Protocol TCP -RemotePort 445 -Program 'System' -Action Allow
New-NetFirewallRule -Display 'Script Generated: RDP (TCP-Out)' -Direction Outbound -Protocol TCP -RemotePort 11139 -Program 'C:\Windows\System32\mstsc.exe' -Action Allow
New-NetFirewallRule -Display 'Script Generated: RDP (UDP-Out)' -Direction Outbound -Protocol UDP -RemotePort 11139 -Program 'C:\Windows\System32\mstsc.exe' -Action Allow
New-NetFirewallRule -Display 'Script Generated: RDP (TCP-In)' -Direction Inbound -Protocol TCP -LocalPort 11139 -Program 'C:\Windows\System32\svchost.exe' -Action Allow
New-NetFirewallRule -Display 'Script Generated: RDP (UDP-In)' -Direction Inbound -Protocol UDP -LocalPort 11139 -Program 'C:\Windows\System32\svchost.exe' -Action Allow
New-NetFirewallRule -Display 'Script Generated: NTP (UDP-Out)' -Direction Outbound -Action Allow -Protocol UDP -RemotePort 123 -Program 'C:\Windows\System32\svchost.exe' -Service 'W32Time'
New-NetFirewallRule -Display 'Script Generated: NCSI' -Direction Outbound -Action Allow -RemoteAddress 192.168.1.1 -Program 'C:\Windows\System32\svchost.exe' -Service 'NlaSvc'
New-NetFirewallRule -Display 'Script Generated: Certutil' -Direction Outbound -Action Allow -Protocol TCP -RemotePort 80 -Program 'C:\Windows\System32\certutil.exe'
New-NetFirewallRule -Display 'Script Generated: Powershell (TCP-Out-80)' -Direction Outbound -Action Allow -Protocol TCP -RemotePort 80 -Program 'C:\Windows\System32\windowspowershell\v1.0\powershell.exe'
New-NetFirewallRule -Display 'Script Generated: Powershell (TCP-Out-443)' -Direction Outbound -Action Allow -Protocol TCP -RemotePort 443 -Program 'C:\Windows\System32\windowspowershell\v1.0\powershell.exe'
Set-NetFirewallRule -DisplayName '*' -Profile "Domain,Private,Public"


<# SMB Server Configuration #>
Write-Host "Setting up Samba Configuration" -ForegroundColor Green
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name LocalAccountTokenFilterPolicy -PropertyType Dword -Value 1 -Force # Enable Administrative Shares
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
# SMB Client Configuration
Set-SmbClientConfiguration -EnableInsecureGuestLogons 0 -Force
Set-SmbClientConfiguration -EnableBandwidthThrottling 0 -Force


<# Remote Desktop Configuration #>
Write-Host "Configuring Remote Desktop" -ForegroundColor Green
# Enable Remote Desktop
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "fDenyTSConnections" -PropertyType DWord -Value 0 -Force
# Don't Adjust Remote Session DPI
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "IgnoreClientDesktopScaleFactor" -PropertyType Dword -Value 1 -Force
# Change Listening Port
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "PortNumber" -PropertyType Dword -Value 11139 -Force
# Prioritize H.264/AVC 444 graphics mode for Remote Desktop Connections
#$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "AVC444ModePreferred" -PropertyType Dword -Value 1 -Force
# Configure H.264/AVC Hardware encoding for Remote Desktop Connections
#$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "AVCHardwareEncodePreferred" -PropertyType Dword -Value 1 -Force
# Increase DWM Frame Capture Interval (If not using AVC codec). 2 is the lowest before dwm.exe goes berserk.
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DWMFRAMEINTERVAL" -PropertyType Dword -Value 2 -Force
# RDP Compression Level (If not using AVC codec)
#$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "MaxCompressionLevel" -PropertyType Dword -Value 0 -Force

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {
    # Use hardware graphics adapters for all Remote Desktop Services sessions
    $Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "bEnumerateHWBeforeSW" -PropertyType Dword -Value 1 -Force
    }


<# Command Line / PowerShell Preferences #>
$Path = "HKU:\Console"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "CtrlKeyShortcutsDisabled" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ExtendedEditKey" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "FilterOnPaste" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "HistoryBufferSize" -PropertyType Dword -Value 999 -Force
New-ItemProperty -Path $Path -Name "InsertMode" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "LineSelection" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "LineWrap" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NumberOfHistoryBuffers" -PropertyType Dword -Value 999 -Force
New-ItemProperty -Path $Path -Name "QuickEdit" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "ScreenBufferSize" -PropertyType Dword -Value 589824135 -Force
New-ItemProperty -Path $Path -Name "WindowSize" -PropertyType Dword -Value 2293895 -Force
New-ItemProperty -Path $Path -Name "WindowPosition" -PropertyType Dword -Value 3276850 -Force


<# Change Scheduled Tasks #>
Write-Host "Changing Default Scheduled Tasks" -ForegroundColor Green
# Disable all Windows Default Tasks, with exceptions.
Get-ScheduledTask -TaskPath "\Microsoft\*" | Where-Object {$_.Taskname -notmatch 'SynchronizeTime' -and $_.Taskname -notmatch 'MsCtfMonitor' -and $_.Taskname -notmatch 'RemoteFXvGPUDisableTask' `
-and $_.Taskname -notmatch 'ResPriStaticDbSync' -and $_.Taskname -notmatch 'WsSwapAssessmentTask' -and $_.Taskname -notmatch 'Sysprep Generalize Drivers' -and $_.Taskname -notmatch 'Device Install Group Policy' `
 -and $_.Taskname -notmatch 'DXGIAdapterCache' -and $_.Taskname -notmatch 'UninstallDeviceTask'} | Disable-ScheduledTask


<# Configure Logging (Event/Channels/WMI #>
Write-Host "Configure Logging" -ForegroundColor Green
<# Event Log Configuration #>
(Get-WinEvent -ListLog *).LogName | %{[System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($_)} # Clear Event Log
# Change Individual Channels
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-LiveId/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-CloudStore/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-UniversalTelemetryClient/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-WindowsSystemAssessmentTool/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-ReadyBoost/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-HelloForBusiness/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-SettingSync/Debug"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-Known Folders API Service"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-SettingSync/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-Store/Operational"; $EventLog.IsEnabled = $false; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-CAPI2/Operational"; $EventLog.IsEnabled = $true; $EventLog.SaveChanges()
$EventLog = Get-WinEvent -ListLog "Microsoft-Windows-Application-Experience/Program-Telemetry"; $EventLog.IsEnabled = $true; $EventLog.SaveChanges() # Actually logs program incompatibility and fixed applied
# Filter Harmless DistributedCOM logging in 'System'.
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-System\{1b562e86-b7aa-4131-badc-b6f3a001407e}"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "Enabled" -PropertyType Dword -Value 0 -Force
# Disable all non-critical WMI loggers (Including third-party)
$Logger = Get-ChildItem -Path 'HKLM:\System\CurrentControlSet\Control\WMI\Autologger' -Recurse -Depth 1 | Where-Object { $_.PSChildName -NotLike 'Circular Kernel Context Logger' -and $_.PSChildName -NotLike 'EventLog-Application' `
 -and $_.PSChildName -NotLike 'EventLog-Security' -and $_.PSChildName -NotLike 'EventLog-System' }
ForEach ($item in $Logger) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'Start' -Value 0 -Force }
# Disable Performance Counters (Causes Vmauthd errors)
#$Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Disable Performance Counters" -PropertyType Dword -Value 1 -Force


<# Bcdedit Entries #>
bcdedit /set description "Windows 10 Enterprise LTSC 2019"
bcdedit /set bootlog yes
bcdedit /set recoveryenabled no
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') { bcdedit /set disabledynamictick yes }


<# Driver Adjustments #>
Write-Host "Change Low-level Driver Settings" -ForegroundColor Green
# Disable Devices in Devmgmt.msc that were already disabled through registry. (Get rid of exclamation mark)
Get-PnpDevice | Where-Object { $_.FriendlyName -match 'Remote Desktop Device Redirector Bus' } | Disable-PnpDevice -Confirm:$false -ea SilentlyContinue
Get-PnpDevice | Where-Object { $_.FriendlyName -match 'Microsoft Hyper-V Virtualization Infrastructure Driver' } | Disable-PnpDevice -Confirm:$false -ea SilentlyContinue
Get-PnpDevice | Where-Object { $_.FriendlyName -match 'Microsoft Storage Spaces Controller' } | Disable-PnpDevice -Confirm:$false -ea SilentlyContinue
Get-PnpDevice | Where-Object { $_.FriendlyName -match 'Microsoft Kernel Debug Network Adapter' } | Disable-PnpDevice -Confirm:$false -ea SilentlyContinue
Get-PnpDevice | Where-Object { $_.FriendlyName -match 'Remote Desktop USB Hub' } | Disable-PnpDevice -Confirm:$false -ea SilentlyContinue

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {

    }

$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') {

    # Nvidia Disable Write Combining (Untested)
    $Path = "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
    New-ItemProperty -Path $Path -Name "DisableWriteCombining" -PropertyType Dword -Value 1 -Force

    # Set Interrupt Affinity (Intel XHCI Controller)
    $InterruptAffinity = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI' -Recurse -Depth 5 -ea SilentlyContinue | Where-Object { $_.PSChildName -Like 'Affinity Policy' -and $_.Name -match 'VEN_8086&DEV_A36D' }
    ForEach ($item in $InterruptAffinity) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'DevicePolicy' -Value 4 -Force; Set-ItemProperty -Path $path -Name 'AssignmentSetOverride' -Type Binary -Value ([byte[]](0x02)) -Force }

    # Set Interrupt Affinity (Intel RAID Controller)
    $InterruptAffinity = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI' -Recurse -Depth 5 -ea SilentlyContinue | Where-Object { $_.PSChildName -Like 'Affinity Policy' -and $_.Name -match 'VEN_8086&DEV_2822' }
    ForEach ($item in $InterruptAffinity) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'DevicePolicy' -Value 4 -Force; Set-ItemProperty -Path $path -Name 'AssignmentSetOverride' -Type Binary -Value ([byte[]](0x80)) -Force }

    # Set MSI Message Limit (Intel Ethernet I210-T1 Gbe NIC)
    $MSIMessageLimit = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI' -Recurse -Depth 5 -ea SilentlyContinue | Where-Object { $_.PSChildName -Like 'MessageSignaledInterruptProperties' -and $_.Name -match 'VEN_8086&DEV_1533' }
    ForEach ($item in $MSIMessageLimit) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'MessageNumberLimit' -Value 2 -Force }

    # Create MSISupported key for Nvidia Geforce 2080 Super as it doesn't exist.
    $MSIMode = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI' -Recurse -Depth 5 -ea SilentlyContinue | Where-Object { $_.Name -match 'VEN_10DE&DEV_1E81' -and $_.PSChildName -match 'Interrupt Management' }
    ForEach ($item in $MSIMode) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; New-Item -Path $path -Name 'MessageSignaledInterruptProperties' -Force; Set-ItemProperty -Path $path\MessageSignaledInterruptProperties -Name 'MSISupported' -Type Dword -Value 1 -Force }

    # Disable Unnecessary Devices (Nvidia USB 3.1 Controller, Nvidia DisplayPort HD Audio, etc)
    Disable-PnpDevice -InstanceId "PCI\VEN_10DE&DEV_10F8&SUBSYS_3FE91458&REV_A1\4&50A803F&0&0108" -confirm:$false
    Disable-PnpDevice -InstanceId "PCI\VEN_10DE&DEV_1AD8&SUBSYS_3FE91458&REV_A1\4&50A803F&0&0208" -confirm:$false
    Disable-PnpDevice -InstanceId "PCI\VEN_10DE&DEV_1AD9&SUBSYS_3FE91458&REV_A1\4&50A803F&0&0308" -confirm:$false
    
    # Disable 'Allow the computer to turn off this device to save power' on all possible devices.
    $device = Get-WmiObject Win32_PnPEntity
    $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi
    foreach ($p in $powerMgmt)
    {
    	$IN = $p.InstanceName.ToUpper()
    	foreach ($h in $device)
    	{
    		$PNPDI = $h.PNPDeviceID
                    if ($IN -like "*$PNPDI*")
                    {
                         $p.enable = $False
                         $p.psbase.put()
                    }
    	}
    }
   
   # Disable 'Allow this device to wake the computer' on all possible devices.
   $device = Get-WmiObject Win32_PnPEntity
    $powerMgmt = Get-WmiObject MSPower_DeviceWakeEnable -Namespace root\wmi
    foreach ($p in $powerMgmt)
    {
    	$IN = $p.InstanceName.ToUpper()
    	foreach ($h in $device)
    	{
    		$PNPDI = $h.PNPDeviceID
                    if ($IN -like "*$PNPDI*")
                    {
                         $p.enable = $False
                         $p.psbase.put()
                    }
    	}
    }
    
    cd '.\Resources\Sonar Essence STX II\'
    & .\DisableSpeakerCompensation.exe
    & .\MicrophoneBoost.exe
    Start-Sleep -Seconds 1
    & .\RestartCard.exe
    cd ..\..
    }

# Disable Line-based Interrupt Emulation on devices where 'MSISupported' key exist. (Mostly applies to In-box HD Audio driver on most platforms)
$MSIMode = Get-ChildItem -Path 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI' -Recurse -Depth 5 | Where-Object { $_.PSChildName -Like 'MessageSignaledInterruptProperties' }
ForEach ($item in $MSIMode) { $path = $item -replace "HKEY_LOCAL_MACHINE","HKLM:"; Set-ItemProperty -Path $path -Name 'MSISupported' -Value 1 -Force }

# Change Mouse/Keyboard Event Buffer Size (Tested)
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "MouseDataQueueSize" -PropertyType Dword -Value 22 -Force
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "KeyboardDataQueueSize" -PropertyType Dword -Value 22 -Force


<# Miscellaneous #>
Write-Host "Applying Miscellaneous Jobs" -ForegroundColor Green
tzutil /s "W. Europe Standard Time"

net accounts /maxpwage:unlimited
net user User User /add
net localgroup Users User /add
net user User /Passwordchg:no
WMIC USERACCOUNT WHERE Name="'User'" SET PasswordExpires=FALSE
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Name "Hide User" -PropertyType String -Value "reg add `"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList`" /v User /t REG_DWORD /d 0 /f" -Force

mkdir C:\Windows\Resources\Wallpapers
copy .\Resources\58-110-165.png C:\Windows\Resources\Wallpapers
COPY .\Resources\aerolite.theme C:\Windows\Resources\Themes
mkdir C:\Windows\SetTimerResolutionService
copy Resources\SetTimerResolutionService.exe C:\Windows\SetTimerResolutionService
C:\Windows\SetTimerResolutionService\SetTimerResolutionService.exe -install
sc.exe config STR start=demand
mkdir C:\Windows\Scripts
rm -f C:\Windows\Scripts\*
copy Scripts\*.ps1 C:\Windows\Scripts

# OldNewExplorer
mkdir C:\Windows\OldNewExplorer
copy Resources\OldNewExplorer\* C:\Windows\OldNewExplorer
$Path = "HKLM:\SOFTWARE\Classes\CLSID\{27DD0F8B-3E0E-4ADC-A78A-66047E71ADC5}"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKLM:\SOFTWARE\Classes\CLSID\{27DD0F8B-3E0E-4ADC-A78A-66047E71ADC5}\InprocServer32"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "(Default)" -PropertyType String -Value "C:\Windows\OldNewExplorer\OldNewExplorer64.dll" -Force
New-ItemProperty -Path $Path -Name "ThreadingModel" -PropertyType String -Value "Apartment" -Force
$Path = "HKLM:\SOFTWARE\Classes\Drive\shellex\FolderExtensions\{27DD0F8B-3E0E-4ADC-A78A-66047E71ADC5}"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "DriveMask" -PropertyType Dword -Value 255 -Force
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\{27DD0F8B-3E0E-4ADC-A78A-66047E71ADC5}"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
New-ItemProperty -Path $Path -Name "NoInternetExplorer" -PropertyType Dword -Value 1 -Force
$Path = "HKU:\Software\Tihiy"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
$Path = "HKU:\Software\Tihiy\OldNewExplorer"; if(-not (Test-Path -Path $Path)){ New-Item -ItemType String -Path $Path }
#New-ItemProperty -Path $Path -Name "Details" -PropertyType Dword -Value 1 -Force
#New-ItemProperty -Path $Path -Name "DriveGrouping" -PropertyType Dword -Value 1 -Force
#New-ItemProperty -Path $Path -Name "HideFolders" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "IEButtons" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "NavBarGlass" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "NoCaption" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "NoIcon" -PropertyType Dword -Value 0 -Force
New-ItemProperty -Path $Path -Name "NoRibbon" -PropertyType Dword -Value 1 -Force
New-ItemProperty -Path $Path -Name "NoUpButton" -PropertyType Dword -Value 0 -Force

# Computer Name
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'A10N-8800E') {
    Rename-Computer -newname 'Nuc'
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'Blade Stealth 13 (Early 2020) - RZ09-0310') {
    Rename-Computer -newname 'Razer'
    mkdir C:\Windows\knifegui
    copy Resources\knifegui\* C:\Windows\knifegui	
    }
$model = (gwmi Win32_ComputerSystem).Model; if ( $model -like 'MS-7B12') { 
    Rename-Computer -newname 'Marctraider-PC'
    copy 'Resources\Sonar Essence STX II\XonarSwitch.exe' C:\Windows
    }

# Purge Temporary Directories and other files
Write-Host "Clean Windows Component Store (WinSxS) and Temporary Directories" -ForegroundColor Green
rm -r C:\Windows\SoftwareDistribution\* -Force
rm -r C:\Users\Administrator\AppData\Local\Temp\* -Force
Remove-Item c:\Users\Public\Desktop\desktop.ini -Force
Remove-Item c:\Users\Administrator\Desktop\desktop.ini -Force
dism /online /Cleanup-Image /StartComponentCleanup # Winsxs (Old updates)


<# Script end #>
Stop-Transcript
Remove-PSDrive -Name HKU
Remove-PSDrive -Name HKCR
Write-Host "Script Done." -ForegroundColor Green