#Requires -Version 7.2

[CmdletBinding()]
param ()
    
begin {
    Set-StrictMode -Version 3
    $ErrorActionPreference = 'Stop' 
}

process {
    $BasePath = $PSScriptRoot | Split-Path

    $Links = @{
        "$($PROFILE.CurrentUserAllHosts)" `
            = "$BasePath\windows\profile.ps1"

        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
            = "$BasePath\windows\terminal,settings.jsonc"

        "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" `
            = "$BasePath\windows\winget,settings.jsonc"

        "$env:APPDATA\gnupg\gpg.conf"       = "$BasePath\.gnupg\gpg.conf"
        "$env:APPDATA\gnupg\gpg-agent.conf" = "$BasePath\.gnupg\gpg-agent.conf"
    }

    $Links.GetEnumerator() | ForEach-Object {
        New-Item $_.Key -Type SymbolicLink -Target $_.Value -Verbose -Force
    }
}
