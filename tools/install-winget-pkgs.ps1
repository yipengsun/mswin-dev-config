function WinGet-Install {
param(
    [string]$Package
)
    Write-Output "install $Package..."
    winget install -e --id $Package -s winget `
        --no-upgrade `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements
}

function WinGet-Install-All {
param(
    [string[]]$Packages
)
    foreach ($pkg in $Packages) {
        WinGet-Install $pkg
    }
}


$pkgsUtils =
'7zip.7zip',
'Piriform.CCleaner',
'jazzdelightsme.WingetPathUpdater'

$pkgsApplications =
'Dropbox.Dropbox',
'Logseq.Logseq',
'Mozilla.Firefox',
'SumatraPDF.SumatraPDF',
'mpv.net',
'Valve.Steam',
'Microsoft.PowerToys'
#'Tencent.WeChat',
#'Tencent.WeCom',
#'Sandboxie.Plus',
#'Apple.iTunes',
#'HandBrake.HandBrake',
#'KDE.Kdenlive',
#'Inkscape.Inkscape'
#'Xmind.Xmind',

$pkgsDevTools =
'Microsoft.PowerShell',
'errata-ai.Vale',
#Alacritty.Alacritty
'wez.wezterm',
'JanDeDobbeleer.OhMyPosh',
####
'Git.Git',
'Rclone.Rclone',
'Kitware.CMake',
'Ninja-build.Ninja',
'Rustlang.Rustup',
'astral-sh.uv',
'JohnMacFarlane.Pandoc',
'Xmake-io.Xmake',
####
'Microsoft.VCRedist.2010.x86',
'Microsoft.VCRedist.2012.x64',
'Microsoft.VCRedist.2012.x86',
'Microsoft.VCRedist.2013.x64',
'Microsoft.VCRedist.2013.x86',
'Microsoft.VCRedist.2015+.x64'


WinGet-Install-All $pkgsUtils
WinGet-Install-All $pkgsApplications
WinGet-Install-All $pkgsDevTools


# vscode
winget install -e --id Microsoft.VisualStudioCode `
    -s winget `
    --no-upgrade `
    --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'


# msvc
winget install -e --id Microsoft.VisualStudio.2022.BuildTools `
    -s winget `
    --no-upgrade `
    --override '--passive --wait --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended'
