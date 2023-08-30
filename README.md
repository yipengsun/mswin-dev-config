# mswin-dev-config
Dev config on Microsoft Windows.


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
