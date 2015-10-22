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

function prompt {
@"
___________________________________________________________________________________________________
$env:USERNAME@$env:COMPUTERNAME  $(gl)  #$((ghy -Count 1 | % Id) + 1) ($(gjb | measure | % Count) bg)
> 
"@
}