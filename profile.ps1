# Enable bash-style completion
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadline
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
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
$d = Get-Location | % Path
$n = (Get-History -Count 1 | % Id) + 1
$j = Get-Job | Measure-Object | % Count
@"
___________________________________________________________________________________________________
$u@$m  $d  #$n ($j bg)
> 
"@
}
