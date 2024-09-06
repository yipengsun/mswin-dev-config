#!/usr/bin/env powershell.exe

# retired
#Write-Output "copying alacritty config to $($env:APPDATA)..."
#Copy-Item -Force -Recurse './alacritty' -Destination $env:APPDATA

# generic config path
$configPath = -join($env:USERPROFILE, '/.config')
if (!(Test-Path -path $configPath)) {New-Item $configPath -Type Directory}

Write-Output "copying wezterm config to $($configPath)..."
Copy-Item -Force -Recurse './wezterm' -Destination $configPath

Write-Output "copying git config to $($env:USERPROFILE)..."
Copy-Item './git/.gitconfig' -Destination $env:USERPROFILE

Write-Output "copying bash config to $($env:USERPROFILE)..."
Copy-Item './bash/.bash_profile' -Destination $env:USERPROFILE
Copy-Item './bash/.bashrc' -Destination $env:USERPROFILE

Write-Output "copying Windows cli-only programs/jars to $($env:USERPROFILE)..."
Copy-Item -Force -Recurse './commands' -Destination $env:USERPROFILE

Write-Output "copying tridactylrc for firefox to $($env:USERPROFILE)..."
Copy-Item './firefox/.tridactylrc' -Destination $env:USERPROFILE

Write-Output "copying WSL2 config to $($env:USERPROFILE)..."
Copy-Item './wsl/.wslconfig' -Destination $env:USERPROFILE

# PowerShell 5
$poshPath = -join([Environment]::GetFolderPath("MyDocuments"), '/WindowsPowerShell')
Write-Output "copying PowerShell config to $($poshPath)..."
if (!(Test-Path -path $poshPath)) {New-Item $poshPath -Type Directory}
Copy-Item './posh/profile.ps1' -Destination $poshPath

# PowerShell 7
$posh7Path = -join([Environment]::GetFolderPath("MyDocuments"), '/PowerShell')
if (!(Test-Path -path $posh7Path)) {New-Item $posh7Path -Type Directory}
Copy-Item './posh/profile.ps1' -Destination $posh7Path
