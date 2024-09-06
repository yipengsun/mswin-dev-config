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
    # NOTE: for now don't check if the dir exists or not.
    # if( !(Test-Path $Dir) ){
    #     Write-warning "Supplied directory was not found!"
    #     return
    # }

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


$cmdDir = -join([Environment]::GetEnvironmentVariable("USERPROFILE"), "\commands")
AddTo-Path $cmdDir

# for LLVM
AddTo-Path "C:\Program Files\LLVM\bin"

# for GNU coreutils on Windows
#AddTo-Path "C:\Program Files\Git\usr\bin"

# for make
#AddTo-Path "C:\Program Files (x86)\GnuWin32\bin"

# for mamba
#$mambaPath = -join([Environment]::GetEnvironmentVariable("USERPROFILE"), "\miniforge3\Scripts")
#AddTo-Path $mambaPath


# set java CLASSPATH
#AddTo-EnvVar (-join($cmdDir, "\*")) "CLASSPATH"


Get-Path "User"
#Get-EnvVar "User" "CLASSPATH"