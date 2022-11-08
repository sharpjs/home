# Enable bash-style completion
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadline
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

# Enable Chocolatey
if ($env:ChocolateyInstall) {
    $ChocolateyProfile = Join-Path $env:ChocolateyInstall helpers chocolateyProfile.psm1
    if (Test-Path $ChocolateyProfile) {
        Import-Module $ChocolateyProfile
    }
}

# Enable posh-git
if (Get-Module posh-git -ListAvailable) {
    Import-Module posh-git
} else {
    function Write-VcsStatus { }
}

# Load the local profile
$LocalProfile = Join-Path $PSScriptRoot Local_profile.ps1
if (Test-Path $LocalProfile) {
    . $LocalProfile
}

# Set my preferred prompt
function prompt {
$u = [Environment]::UserName
$m = [Environment]::MachineName
$d = Get-Location | ForEach-Object Path
$g = Write-VcsStatus
$n = (Get-History -Count 1 | ForEach-Object Id) + 1
$j = Get-Job | Measure-Object | ForEach-Object Count
@"
___________________________________________________________________________________________________
$u@$m  $d$g  #$n ($j bg)
> 
"@
}
