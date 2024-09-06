# generic config path
$configPath = -join($env:USERPROFILE, '/.config')
if (!(Test-Path -path $configPath)) {
    New-Item $configPath -Type Directory
}


# misc config
Write-Output "copy wezterm config to $($configPath)..."
Copy-Item -Force -Recurse './wezterm' -Destination $configPath

Write-Output "copy git config to $($env:USERPROFILE)..."
Copy-Item './git/.gitconfig' -Destination $env:USERPROFILE

Write-Output "copy bash config to $($env:USERPROFILE)..."
Copy-Item './bash/.bash_profile' -Destination $env:USERPROFILE
Copy-Item './bash/.bashrc' -Destination $env:USERPROFILE

Write-Output "copy Windows cli commands/jars to $($env:USERPROFILE)..."
Copy-Item -Force -Recurse './commands' -Destination $env:USERPROFILE

Write-Output "copy tridactylrc for firefox to $($env:USERPROFILE)..."
Copy-Item './firefox/.tridactylrc' -Destination $env:USERPROFILE

Write-Output "copy WSL2 config to $($env:USERPROFILE)..."
Copy-Item './wsl/.wslconfig' -Destination $env:USERPROFILE

#Write-Output "copying alacritty config to $($env:APPDATA)..."
#Copy-Item -Force -Recurse './alacritty' -Destination $env:APPDATA


# PowerShell 5
$pwshPath = -join([Environment]::GetFolderPath("MyDocuments"), '/WindowsPowerShell')
Write-Output "copying PowerShell config to $($pwshPath)..."
if (!(Test-Path -path $pwshPath)) {
    New-Item $pwshPath -Type Directory
}
Copy-Item './pwsh/profile.ps1' -Destination $pwshPath

# PowerShell 7
$pwsh7Path = -join([Environment]::GetFolderPath("MyDocuments"), '/PowerShell')
if (!(Test-Path -path $pwsh7Path)) {
    New-Item $pwsh7Path -Type Directory
}
Copy-Item './pwsh/profile.ps1' -Destination $pwsh7Path


# uutils symblinks
Write-Output "populating uutil symblinks..."
$utils = "512sum",
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

$commandPath = -join($env:USERPROFILE, "/commands")
$oldBin = -join($commandPath, "/coreutils.exe")
Foreach ($util in $utils) {
    $newBin = -join($commandPath, "/", $util, ".exe")
    if (!(Test-Path -path $newBin)) {
        New-Item -ItemType SymbolicLink -Path $newBin -Target $oldBin
    }
}