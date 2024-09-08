##########
# config #
##########

# line editor
Set-PSReadLineOption -EditMode Emacs

# tab completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PsReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


#################
# env variables #
#################

$env:VIRTUAL_ENV_DISABLE_PROMPT = 1


###########
# aliases #
###########

# NOTE: do not use New-Alias as that prodcues an error on profile reload!
Set-Alias -Name g -Value git
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim

# 'ls' already exist. just remove it
# PowerShell 5
If (Test-Path Alias:ls) { Remove-Item Alias:ls }
Function lsColored { ls.exe --color $args }
Set-Alias -Name ls -Value lsColored

If (Test-Path Alias:rm) { Remove-Item Alias:rm }


# initiate oh-my-posh
# get folder path from $PROFILE
$profileDir = Split-Path -Parent $PROFILE
oh-my-posh init pwsh --config (-join($profileDir, "/config.json")) | Invoke-Expression
