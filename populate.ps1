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

# uutils symblinks
Write-Output "populating uutil symblinks..."
$utils = "arch", "b2sum", "b3sum", "base32", "base64", "basename", "basenc", "cat", "cksum", "comm", "cp",
"csplit", "cut", "date", "dd", "df", "dir", "dircolors", "dirname", "du", "echo", "env", "expand", "expr",
"factor", "false", "fmt", "fold", "hashsum", "head", "hostname", "join", "link", "ln", "ls", "md5sum", "mkdir",
"mktemp", "more", "mv", "nl", "nproc", "numfmt", "od", "paste", "pr", "printenv", "printf", "ptx", "pwd",
"readlink", "realpath", "relpath", "rm", "rmdir", "seq", "sha1sum", "sha224sum", "sha256sum", "sha3-224sum",
"sha3-256sum", "sha3-384sum", "sha3-", "512sum", "sha384sum", "sha3sum", "sha512sum", "shake128sum", "shake256sum",
"shred", "shuf", "sleep", "sort", "split", "sum", "sync", "tac", "tail", "tee", "test", "touch", "tr", "true",
"truncate", "tsort", "uname", "unexpand", "uniq", "unlink", "vdir", "wc", "whoami", "yes"

$commandPath = -join($env:USERPROFILE, "/commands")
$oldBin = -join($commandPath, "/coreutils.exe")
Foreach ($util in $utils) {
    $newBin = -join($commandPath, "/", $util, ".exe")
    New-Item -ItemType SymbolicLink -Path $newBin -Target $oldBin
}