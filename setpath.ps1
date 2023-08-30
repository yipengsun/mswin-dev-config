#!/usr/bin/env powershell.exe

function Get-Path{
param(
    [string]$User
)

    $path = [Environment]::GetEnvironmentVariable("PATH", $User)
    Write-output $path
}

function AddTo-Path{
param(
    [string]$Dir
)

    if( !(Test-Path $Dir) ){
        Write-warning "Supplied directory was not found!"
        return
    }
    $PATH = [Environment]::GetEnvironmentVariable("PATH", "User")
    if( $PATH -notlike "*"+$Dir+"*" ){
        [Environment]::SetEnvironmentVariable("PATH", "$Dir;$PATH", "User")
    }
}

# set path
$cmdpath = -join([Environment]::GetEnvironmentVariable("USERPROFILE"), "\", "commands")
AddTo-Path $cmdpath

# print out
Get-Path User
