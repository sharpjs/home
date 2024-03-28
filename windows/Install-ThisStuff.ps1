#Requires -Version 7.2

[CmdletBinding()]
param ()
    
begin {
    Set-StrictMode -Version 3
    $ErrorActionPreference = 'Stop' 
}

process {
    $Links = @{
        "$($PROFILE.CurrentUserAllHosts)" `
            = "$PSScriptRoot\profile.ps1"

        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" `
            = "$PSScriptRoot\terminal,settings.jsonc"

        "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" `
            = "$PSScriptRoot\winget,settings.jsonc"
    }

    $Links.GetEnumerator() | ForEach-Object {
        New-Item $_.Key -Type SymbolicLink -Target $_.Value -Verbose -Force
    }
}
