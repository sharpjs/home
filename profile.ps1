if ([Environment]::OSVersion.Version.Major -lt 10) {
    Import-Module PsGet
}

if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadline
    Set-PSReadlineOption -EditMode Emacs
}

$LocalProfile = "$PSScriptRoot\Local_profile.ps1"
if (Test-Path $LocalProfile) {
    . $LocalProfile
}
