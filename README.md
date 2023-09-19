# mswin-dev-config
Dev config on Microsoft Windows.

Copy config via:

```
./populate.ps1
```


## PowerShell script

By default Windows may prevent execution of PS scripts. To fix that:

```
set-executionpolicy unrestricted
```


## PATH

Some Windows command-line only programs are needed (w.r.t. Interoperability w/ WSL).
They need to be made available in `$PATH`. To do so:

```
./setpath.ps1
```


## Fonts

`FiraCode Nerd Font Mono` is required. Consult the `nerd-font` repo on
installation in Windows.


## PowerShell

Install `oh-my-posh` following instructions [here](https://github.com/jandedobbeleer/oh-my-posh).
If VS code is installed, the PowerShell profile can be edited with:

```
code $PROFILE
```


## Add a US keyboard

See [here](https://www.bilibili.com/read/cv14827165/).


## Install build tools

```
winget install Microsoft.VisualStudio.2022.BuildTools
winget install Microsoft.VisualStudio.2022.Community
winget install CMake
```
