#!/usr/bin/env powershell.exe

Write-output 'copying alacrity config...'
Copy-Item -Force './alacritty' -Destination $env:APPDATA

Write-output 'copying git config...'
Copy-Item './git/.gitconfig' $env:USERPROFILE

Write-output 'copying bash config...'
Copy-Item './bash/.bash_profile' $env:USERPROFILE

Write-output 'copying Windows cli-only programs...'
Copy-Item -Force './commands' $env:USERPROFILE
