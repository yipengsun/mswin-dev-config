$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$parentDir = Split-Path -Path $scriptDir -Parent

$configDir = -join($env:USERPROFILE, '\.config')
if (!(Test-Path -path $configDir)) {
    New-Item $configDir -Type Directory
}

$nvimDir = -join($configDir, '\nvim')
if (!(Test-Path -path $nvimDir)) {
    New-Item $nvimDir -Type Directory
}

$spaceVimDir = -join($nvimDir, '\SpaceVim')
$spaceVimConfigDir = -join($env:USERPROFILE, '\.SpaceVim.d')


# link SpaceVim bundle
$localSpaceVimDir = -join($parentDir, '\submodules\SpaceVim')
if (!(Test-Path -path $spaceVimDir)) {
    Write-Host "Link SpaceVim dir..." -ForegroundColor Green
    New-Item -ItemType SymbolicLink -Path $spaceVimDir -Target $localSpaceVimDir
}

# link SpaceVim config
$localSpaceVimConfigDir = -join($parentDir, '\config\.SpaceVim.d')
if (!(Test-Path -path $spaceVimConfigDir)) {
    Write-Host "Link SpaceVim config dir..." -ForegroundColor Green
    New-Item -ItemType SymbolicLink -Path $spaceVimConfigDir -Target $localSpaceVimConfigDir
}