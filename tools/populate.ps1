$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$parentDir = Split-Path -Path $scriptDir -Parent

$configDir = -join($env:USERPROFILE, '\.config')
if (!(Test-Path -path $configDir)) {
    New-Item $configDir -Type Directory
}


# helper functions
function CopyTo-Wrapper {
param(
    [string]$Source,
    [string]$Destination
)
    Write-Output "copy $Source to $Destination..."
    Copy-Item -Force -Recurse $Source $Destination
}


Write-Host "Copy cli commands..." -ForegroundColor Green
CopyTo-Wrapper (-join($parentDir, '\commands')) $env:USERPROFILE


Write-Host "Copy configuration files..." -ForegroundColor Green
$localConfigDir = -join($parentDir, '\config')

CopyTo-Wrapper (-join($localConfigDir, '\wezterm')) $configDir

CopyTo-Wrapper (-join($localConfigDir, '\bash\.bash_profile')) $env:USERPROFILE
CopyTo-Wrapper (-join($localConfigDir, '\bash\.bashrc')) $env:USERPROFILE

CopyTo-Wrapper (-join($localConfigDir, '\firefox\.tridactylrc')) $env:USERPROFILE

CopyTo-Wrapper (-join($localConfigDir, '\wsl\.wslconfig')) $env:USERPROFILE

# git
CopyTo-Wrapper (-join($localConfigDir, '\git\.gitconfig')) $env:USERPROFILE
if ((Get-Command nvim -ErrorAction SilentlyContinue) -and (Get-Command git -ErrorAction SilentlyContinue)) {
    git config --global core.editor nvim
}

#CopyTo-Wrapper (-join($localConfigDir, '\alacritty')) $env:USERPROFILE


Write-Host "Copy PowerShell config..." -ForegroundColor Green

$pwshPath = -join([Environment]::GetFolderPath("MyDocuments"), '\WindowsPowerShell')
if (!(Test-Path -path $pwshPath)) {
    New-Item $pwshPath -Type Directory
}
CopyTo-Wrapper (-join($localConfigDir, '\pwsh\profile.ps1')) $pwshPath
CopyTo-Wrapper (-join($localConfigDir, '\pwsh\config.json')) $pwshPath

$pwsh7Path = -join([Environment]::GetFolderPath("MyDocuments"), '\PowerShell')
if (!(Test-Path -path $pwsh7Path)) {
    New-Item $pwsh7Path -Type Directory
}
CopyTo-Wrapper (-join($localConfigDir, '\pwsh\profile.ps1')) $pwsh7Path
CopyTo-Wrapper (-join($localConfigDir, '\pwsh\config.json')) $pwsh7Path


Write-Host "Populate uutil symblinks..." -ForegroundColor Green

$utils =
"512sum",
"arch",
"b2sum", "b3sum", "base32", "base64", "basename", "basenc",
"cat", "cksum", "comm", "cp", "csplit", "cut",
"date", "dd", "df", "dir", "dircolors", "dirname", "du",
"echo", "env", "expand", "expr",
"factor", "false", "fmt", "fold",
"hashsum", "head", "hostname",
"join",
"link", "ln", "ls",
"md5sum", "mkdir", "mktemp", "more", "mv",
"nl", "nproc", "numfmt",
"od",
"paste", "pr", "printenv", "printf", "ptx", "pwd",
"readlink", "realpath", "relpath", "rm", "rmdir",
"sha1sum", "sha224sum", "sha256sum", "sha384sum", "sha3sum", "sha512sum",
"sha3-224sum", "sha3-256sum", "sha3-384sum", "sha3-",
"shake128sum", "shake256sum",
"seq", "shred", "shuf", "sleep", "sort", "split", "sum", "sync",
"tac", "tail", "tee", "test", "touch", "tr", "true", "truncate", "tsort",
"uname", "unexpand", "uniq", "unlink",
"vdir",
"wc", "whoami",
"yes"

$commandPath = -join($env:USERPROFILE, "\commands")
$oldBin = -join($commandPath, "\coreutils.exe")
Foreach ($util in $utils) {
    $newBin = -join($commandPath, "\", $util, ".exe")
    if (!(Test-Path -path $newBin)) {
        New-Item -ItemType SymbolicLink -Path $newBin -Target $oldBin
    }
}
