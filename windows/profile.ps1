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

# Set the location if not already set
if ($PWD.Path -eq $HOME) {
    "D:\Code", "D:\Projects", "$HOME\Code", "$HOME/src" `
    | Where-Object { Test-Path $_ -PathType Container } `
    | Select-Object -First 1 `
    | Set-Location
}

# Aliases
New-Alias -Name k -Value kubectl

# Load the local profile
$LocalProfile = Join-Path $PSScriptRoot Local_profile.ps1
if (Test-Path $LocalProfile) {
    . $LocalProfile
}
Remove-Variable LocalProfile

# Use Starship for custom prompt
Invoke-Expression (&starship init powershell)
