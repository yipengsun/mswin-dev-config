#!/usr/bin/env powershell.exe

function Get-EnvVar{
param(
    [string]$User,
    [string]$Var
)
    $value = [Environment]::GetEnvironmentVariable($Var, $User)
    Write-output $value
}

function AddTo-EnvVar{
param(
    [string]$Dir,
    [string]$Var
)
    if( !(Test-Path $Dir) ){
        Write-warning "Supplied directory was not found!"
        return
    }

    $value = [Environment]::GetEnvironmentVariable($Var, "User")
    if( $value -notlike "*"+$Dir+"*" ){
        [Environment]::SetEnvironmentVariable($Var, "$Dir;$value", "User")
    }
}

function Get-Path{
param(
    [string]$User
)
    Get-EnvVar $User "PATH"
}

function AddTo-Path{
param(
    [string]$Dir
)
    AddTo-EnvVar $Dir "PATH"
}

# set PATH
$cmdpath = -join([Environment]::GetEnvironmentVariable("USERPROFILE"), "\", "commands")
AddTo-Path $cmdpath

# for GNU coreutils on Windows
AddTo-Path "C:\Program Files\Git\usr\bin"

# for LLVM
AddTo-Path "C:\Program Files\LLVM\bin"

# for make
#AddTo-Path "C:\Program Files (x86)\GnuWin32\bin"

# set java CLASSPATH
AddTo-EnvVar $cmdpath CLASSPATH

# print out
Get-Path User
Get-EnvVar User CLASSPATH