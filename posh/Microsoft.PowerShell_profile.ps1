oh-my-posh init pwsh | Invoke-Expression

# aliases
# NOTE: do not use New-Alias as that prodcues an error on profile reload!
Set-Alias -Name g -Value git

# 'ls' already exist. just remove it
# PowerShell 5
Remove-Item Alias:ls