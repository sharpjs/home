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

# # Enable posh-git
# if (Get-Module posh-git -ListAvailable) {
#     Import-Module posh-git
# } else {
#     function Write-VcsStatus { }
# }

# Set the location if not already set
if ($PWD.Path -eq $HOME) {
    "D:\Code", "D:\Projects", "$HOME\Code", "$HOME/src" `
    | Where-Object { Test-Path $_ -PathType Container } `
    | Select-Object -First 1 `
    | Set-Location
}

# Load the local profile
$LocalProfile = Join-Path $PSScriptRoot Local_profile.ps1
if (Test-Path $LocalProfile) {
    . $LocalProfile
}
Remove-Variable LocalProfile

# 54 64 72
#D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;RPWPCR;;;IU)(A;;CCLCSWLOCRRC;;;SU)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)

# Set my preferred prompt
function prompt {

git status -b --porcelain=v2 no-files 2>$null `
    | Where-Object { $_ -match '^# branch\.(head|ab) (.+)' } `
    | ForEach-Object { Set-Variable $Matches.1 $Matches.2 } `
    > $null

$u = [Environment]::UserName
$m = [Environment]::MachineName
$d = Get-Location | ForEach-Object Path
$n = (Get-History -Count 1 | ForEach-Object Id) + 1
$j = Get-Job | Measure-Object | ForEach-Object Count
$p = (Get-Variable PromptNotice -Scope Global -ErrorAction Ignore)?.Value

#$f1 = "38;5"
#$b1 = "48;5"

$f3 = "38;2"
$b3 = "48;2"

#$dsteel = "54;62;72"
$gray   = "160;160;160"
$blue   = "104;118;138"
$blue   = "65;74;87"

$reset = "0"
$bold  = "1"
$inv   = "7"
$noinv = "27"

$Width = ($Host)?.UI?.RawUI?.WindowSize?.Width ?? 99

$hr = "" * $Width

$v = "`e[40m`e[${b3};${gray}m"
$p = $p ? "`e[${bold};30;43m $p `e[33;40m" : "`e[${f3};${blue}m"

$g = $head ? " $v  $head $ab" : $Null

#$g = $head ?  "
#`e[${f3};${gray}m $head $ab" : $null

$u = $(if ($u -eq "Jeff") {$null} else {"$u $v "})

$t = "`e[$($Width - 5)G $(Get-Date -Format HH:mm)"

@"
`e[${f3};${blue}m$hr
`e[${b3};${gray};${inv}m $u$m $v $d$g $v #$n `e[40;${noinv}m$t

$p`e[${reset}m 
"@
}
