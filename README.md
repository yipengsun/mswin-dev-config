# mswin-dev-config

Dev config on Microsoft Windows.


## Before you proceed

1. Make sure `winget` is available
2. Use `winget` to install `Git.Git`
3. Clone this repo, forget about submodules for now


## Usage

```powershell
# windows prevents script execution by default. to fix that:
#Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force


# install winget packages
.\tools\install-winget-pkgs.ps1
# then manually install git-annex from its official site

# install 'FiraCode Nerd Font Mono'
oh-my-posh font install FiraCode

.\tools\config-generic.ps1
.\tools\set-path.ps1


# optional: de-bloat to restore a win10-like ui
cd submodules\Win11Debloat
git submodule update --init .
Run.bat


# optional: install & configure neovim
cd submodules\SpaceVim
git submodule update --init .
..\..\tools\config-nvim.ps1
```


## Tips and tricks

### Download Windows

**DO NOT** try to download Windows from [this site](https://massgrave.dev/)!


### List winget-installed applications

```powershell
(winget list) -match ' winget$'
```


### Install FiraCode manually

```powershell
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
.\install.ps1 FiraCode
```


### WSL

#### Install pre-released version

```powershell
wsl --update --pre-release
```

#### Export/Import image

```powershell
# if you use docker for windows, spin down any containers, then stop docker

wsl --terminate NixOS
wsl --shutdown
wsl --export NixOS D:\WSL\backup\NixOS.tar
# optional: unregister
wsl --unregister NixOS

# on a new computer then import
wsl --import NixOS D:\WSL\backup\NixOS.tar
# or
wsl --import-in-place NixOS D:\WSL\NixOS\ext4.vhdx
wsl --setdefault NixOS
```

#### Automatically reduce disk image size

```powershell
wsl --manage NixOS -s true
```

#### Manually reduce disk image size

Inside a WSL shell, run:

```shell
fstrim -a
```

then:

```powershell
wsl --manage NixOS -s false

diskpart
# inside diskpart prompt
select vdisk file="<distro-location>.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
exit
# back to powershell

wsl --manage NixOS -s true
```

#### Increase available memory

```powershell
wsl --shutdown

Write-Output "[wsl2]
memory=28GB" >> "${env:USERPROFILE}\.wslconfig"
```


### PowerShell

#### Use VS code to edit PowerShell profile

```
code $PROFILE
```

#### Set PowerShell 7 as the default shell in _Windows Terminal_

**Settings** > **Startup**, then choose **PowerShell** from the Default profile.


### Windows tweaks

#### Use old-style context menu

```
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```

#### Add a US keyboard

This is only needed for Windows 11 home.
See [here](https://www.bilibili.com/read/cv14827165/).

#### Take ownership of a folder

1. Add _Take Ownership_ to context menu with `EcMenu`
2. Right click to take ownership of `<foldername>`
3. `takeown /f <foldername> /r /d y`

#### Manually change user folder locations

Locations of folders like _Music_ can be changed via the following registry item:

```
HKEY_CURRENT_USER \ Software \ Microsoft \ Windows \ CurrentVersion \ Explorer \ User Shell Folders
```

#### Open application in current monitor

Use PowerToy: **FancyZones** > **Move newly created windows to current active monitor**

#### Pin a `winget` package version

Doing the following to prevent the package from updating with `winget upgrade --all`:

```powershell
# omit `--version` to pin on current version
winget pin add --id SandBoxie.Plus --version 1.14.8

winget pin list  # check that the op was successful
```
