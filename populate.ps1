#!/usr/bin/env powershell.exe

Write-Output "copying alacritty config to $($env:APPDATA)..."
Copy-Item -Force -Recurse './alacritty' -Destination $env:APPDATA

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
$poshpath = -join([Environment]::GetFolderPath("MyDocuments"), '\WindowsPowerShell')
Write-Output "copying PowerShell config to $($poshpath)..."
if (!(Test-Path -path $poshpath)) {New-Item $poshpath -Type Directory}
Copy-Item './posh/profile.ps1' -Destination $poshpath

# PowerShell 7
$posh7path = -join([Environment]::GetFolderPath("MyDocuments"), '\PowerShell')
if (!(Test-Path -path $posh7path)) {New-Item $posh7path -Type Directory}
Copy-Item './posh/profile.ps1' -Destination $posh7path
