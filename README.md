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


## Download Windows

**DO NOT** try to download Windows from [this site](https://massgrave.dev/)!


## Install applications

Most applications are installed via `winget`. To list them:

```
(winget list) -match ' winget$'
```


## WSL

### Install pre-released version

```
wsl --update --pre-release
```

### Export/Import image

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

### Automatically reduce disk image size

This requires a pre-release version of `wsl` (as of 23-10-20):

```
wsl --manage NixOS -s true
```

### Manually reduce disk image size

Inside a WSL shell, run:

```
fstrim -a
```

then:

```
wsl --manage NixOS -s false

diskpart

select vdisk file="<distro-location>.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
exit

wsl --manage NixOS -s true
```

### Increase available memory

```
wsl --shutdown

Write-Output "[wsl2]
memory=28GB" >> "${env:USERPROFILE}\.wslconfig"
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

It is recommended to upgrade to PowerShell 7. To do so:

```
winget install --id Microsoft.Powershell -s winget
```

To set PowerShell 7 as the default shell in _Windows Terminal_:
**Settings** > **Startup**, then choose **PowerShell** from the Default profile.


## Windows tweaks

### General

Use [this script](https://github.com/Raphire/Win11Debloat) to debloat and restore a Windows-10 like UI

### Use old-style context menu

The script above can also do this

```
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```

### Add a US keyboard

This is only needed for Windows 11 home.
See [here](https://www.bilibili.com/read/cv14827165/).

### Take ownership of a folder

1. Add _Take Ownership_ to context menu with `EcMenu`
2. Right click to take ownership of `<foldername>`
3. `takeown /f <foldername> /r /d y`

### Manually change user folder locations

Locations of folders like _Music_ can be changed via the following registry item:

```
HKEY_CURRENT_USER \ Software \ Microsoft \ Windows \ CurrentVersion \ Explorer \ User Shell Folders
```