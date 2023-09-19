# line editor
Set-PSReadLineOption -EditMode Emacs

# aliases
# NOTE: do not use New-Alias as that prodcues an error on profile reload!
Set-Alias -Name g -Value git
Set-Alias -Name vi -Value vim

# 'ls' already exist. just remove it
# PowerShell 5
If (Test-Path Alias:ls) { Remove-Item Alias:ls }
Function lsColored { ls.exe --color $args }
Set-Alias -Name ls -Value lsColored

If (Test-Path Alias:rm) { Remove-Item Alias:rm }

# initiate oh-my-posh 
oh-my-posh init pwsh | Invoke-Expression
