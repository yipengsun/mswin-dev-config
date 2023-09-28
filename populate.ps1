#!/usr/bin/env powershell.exe

Write-Output "copying alacrity config to $($env:APPDATA)..."
Copy-Item -Force -Recurse './alacritty' -Destination $env:APPDATA

Write-Output "copying git config to $($env:USERPROFILE)..."
Copy-Item './git/.gitconfig' -Destination $env:USERPROFILE

Write-Output "copying bash config to $($env:USERPROFILE)..."
Copy-Item './bash/.bash_profile' -Destination $env:USERPROFILE
Copy-Item './bash/.bashrc' -Destination $env:USERPROFILE

Write-Output "copying Windows cli-only programs to $($env:USERPROFILE)..."
Copy-Item -Force -Recurse './commands' -Destination $env:USERPROFILE

$poshpath = -join([Environment]::GetFolderPath("MyDocuments"), '\WindowsPowerShell')
Write-Output "copying PowerShell config to $($poshpath)..."
Copy-Item './posh/profile.ps1' -Destination $poshpath
