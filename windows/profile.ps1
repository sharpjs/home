# Enable bash-style completion
if ($Host.Name -eq 'ConsoleHost') {
    Import-Module PSReadline
    Set-PSReadLineOption -EditMode Vi -BellStyle None
    # Restore bash-like completion behavior, turned off by vi mode
    Set-PSReadLineKeyHandler -ViMode Command -Key Tab       -Function Complete
    Set-PSReadLineKeyHandler -ViMode Insert  -Key Tab       -Function Complete
    Set-PSReadLineKeyHandler -ViMode Command -Key Shift+Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -ViMode Insert  -Key Shift+Tab -Function MenuComplete
}

# Enable Chocolatey
if ($env:ChocolateyInstall) {
    $ChocolateyProfile = Join-Path $env:ChocolateyInstall helpers chocolateyProfile.psm1
    if (Test-Path $ChocolateyProfile) {
        Import-Module $ChocolateyProfile
    }
    Remove-Variable ChocolateyProfile
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
Remove-Variable LocalProfile

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
