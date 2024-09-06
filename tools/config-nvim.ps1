$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$parentDir = Split-Path -Path $scriptDir -Parent

$nvimDir = -join($env:LOCALAPPDATA, '\nvim')
$spaceVimConfigDir = -join($env:USERPROFILE, '\.SpaceVim.d')


# link SpaceVim bundle
$localSpaceVimDir = -join($parentDir, '\submodules\SpaceVim')
if (!(Test-Path -path $nvimDir)) {
    Write-Host "Link SpaceVim dir..." -ForegroundColor Green
    New-Item -ItemType SymbolicLink -Path $nvimDir -Target $localSpaceVimDir
}

# link SpaceVim config
$localSpaceVimConfigDir = -join($parentDir, '\config\.SpaceVim.d')
if (!(Test-Path -path $spaceVimConfigDir)) {
    Write-Host "Link SpaceVim config dir..." -ForegroundColor Green
    New-Item -ItemType SymbolicLink -Path $spaceVimConfigDir -Target $localSpaceVimConfigDir
}