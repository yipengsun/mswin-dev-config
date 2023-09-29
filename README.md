# mswin-dev-config
Dev config on Microsoft Windows.

Copy config via:

```
./populate.ps1
```

By default Windows prevents execution of PS scripts. To change that:

```
Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
```

Some command-line utility programs are need for my daily workflows. They are
either shipped directly with this repo (e.g. `fd`) or installed separately
(e.g. `clang-format` with `LLVM.LLVM`).
To make them available in `$PATH`:

```
./setpath.ps1
```


## Applications installed w/ `winget`

```
(winget list) -match ' winget$'
```

with the following output:

```shell
# utils
7-Zip 23.01 (x64)                          7zip.7zip                                     23.01                   winget
CCleaner                                   Piriform.CCleaner                             6.16                    winget
#Sandboxie-Plus v1.10.5                     Sandboxie.Plus                                1.11.2                  winget
#Speccy                                     Piriform.Speccy                               1.32                    winget
#PowerToys (Preview) x64                    Microsoft.PowerToys                           0.73.0                  winget

# applications
Dropbox                                    Dropbox.Dropbox                               183.4.7058              winget
Logseq                                     Logseq.Logseq                                 0.9.18                  winget
Mozilla Firefox (x64 zh-CN)                Mozilla.Firefox                               117.0.1                 winget
SumatraPDF                                 SumatraPDF.SumatraPDF                         3.4.6                   winget
#WeLink                                     Huawei.Welink                                 7.32.7                  winget
#Inkscape                                   Inkscape.Inkscape                             1.3.0                   winget
#Logi Bolt                                  Logitech.LogiBolt                             1.2.6024.0              winget
#Logitech Unifying                          Logitech.UnifyingSoftware                     2.52.33                 winget

# dev
Alacritty                                  Alacritty.Alacritty                           0.12.2                  winget
Git                                        Git.Git                                       2.42.0.2                winget
Oh My Posh version 18.10.1                 JanDeDobbeleer.OhMyPosh                       18.10.1                 winget
XMake build utility (x64)                  Xmake-io.Xmake                                2.7.9+20230515          winget
CMake                                      Kitware.CMake                                 3.27.6                  winget
####
Visual Studio                              Microsoft.VisualStudio.2022.BuildTools        17.7.4                  winget
#Visual Studio Community 2022               Microsoft.VisualStudio.2022.Community         17.7.4                  winget
####
Microsoft Visual Studio Code (User)        Microsoft.VisualStudioCode                    1.82.2                  winget
####
Microsoft Visual C++ 2010  x64 Redistribu  Microsoft.VCRedist.2010.x64                   10.0.40219              winget
Microsoft Visual C++ 2012 Redistributable  Microsoft.VCRedist.2012.x64                   11.0.61030.0            winget
Microsoft Visual C++ 2012 Redistributable  Microsoft.VCRedist.2012.x86                   11.0.61030.0            winget
Microsoft Visual C++ 2013 Redistributable  Microsoft.VCRedist.2013.x64                   12.0.40664.0            winget
Microsoft Visual C++ 2013 Redistributable  Microsoft.VCRedist.2013.x86                   12.0.40664.0            winget
Microsoft Visual C++ 2015-2022 Redistribu  Microsoft.VCRedist.2015+.x64                  14.38.32919.0           winget

# games
Steam                                      Valve.Steam                                   2.10.91.91              winget
```


## Export/Import WSL2 image

```shell
# if you use docker for windows, spin down any containers, then stop docker

wsl --terminate NixOS
wsl --shutdown
wsl --export Ubuntu D:\WSL\backup\NixOS.tar  # can use '--vhd' flag
# optional: unregister
wsl --unregister NixOS

# on a new computer then import
wsl --import NixOS D:\WSL\backup\NixOS.tar
# or
wsl --import-in-place NixOS D:\WSL\NixOS\ext4.vhdx
wsl --setdefault NixOS
```


## Fonts

`FiraCode Nerd Font Mono` is required. To install, go to project root of
`nerd-fonts` then:

```
./install.ps1 FiraCode
```


## PowerShell config

Install `oh-my-posh` with:

```
winget install JanDeDobbeleer.OhMyPosh -s winget
```

If VS code is installed, the PowerShell profile can be edited with:

```
code $PROFILE
```


## Add a US keyboard

See [here](https://www.bilibili.com/read/cv14827165/).


## Install build tools

```
winget install -e --id Microsoft.VisualStudio.2022.BuildTools --override "--passive --wait --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended"
winget install CMake
```


## Take ownership of a folder

First, add _Take Ownership_ to context menu with `EcMenu`, then right click to
take ownership of `<foldername>`, finally:

```
takeown /f <foldername> /r /d y
```


## Use old-style context menu

```
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```


## Manually change user folder locations

Locations of folders like _Music_ can be changed via the following registry
item:

```
HKEY_CURRENT_USER \ Software \ Microsoft \ Windows \ CurrentVersion \ Explorer \ User Shell Folders
```