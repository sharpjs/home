[CmdletBinding(SupportsShouldProcess)]
param (
    [switch] $SkipScoop,
    [switch] $SkipWinGet
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
$FromMe = @{ ForegroundColor = "Cyan" }

#------------------------------------------------------------------------------
Write-Host "Checking Scoop" @FromMe

$Output = & scoop status *>&1

if ($Output -and $Output[0] -like '*bucket(s) out of date*') {
    & scoop update #*> $null
    $Output = & scoop status --local *>&1
}

$ScoopUpdates = @(
    foreach ($Item in $Output) {
        # Ignore output that is not a package update
        if (-not ($Item | Get-Member Name)) { continue }

        [PSCustomObject] @{
            Id         = $Item.'Name' # Scoop does not use separate ids
            Name       = $Item.'Name'
            OldVersion = $Item.'Installed Version'
            NewVersion = $Item.'Latest Version'
            # unused:    $Item.'Missing Dependencies'
            # unused:    $Item.'Info'
            Source     = 'Scoop'
        }
    }
)

#------------------------------------------------------------------------------
Write-Host "Checking WinGet" @FromMe

$Output  = & winget upgrade --include-unknown *>&1
$InTable = $false

$WinGetUpdates = @(
    foreach ($Line in $Output) {
        # Skip until table header divider is found
        if (-not $InTable) {
            if ($Line -match '^-{10,}') { $InTable = $true }
            continue
        }

        # Ignore output that is not a package update
        if ($Line -match 'upgrades available|winget pin') { continue }

        # WinGet table columns: Name Id Version Available
        #                       ^^^^ may contain spaces
        if ($Line -notmatch '^(.+?) +([^ \r\n]+) +([^ \r\n]+) +([^ \r\n]+) *$') {
            continue
        }

        [PSCustomObject] @{
            Name       = $Matches[1]
            Id         = $Matches[2]
            OldVersion = $Matches[3]
            NewVersion = $Matches[4]
            Source     = 'WinGet'
        }
    }
)

#------------------------------------------------------------------------------
Write-Host "Checking Scoop against VirusTotal" @FromMe

# > scoop virustotal vim
# WARN  main/vim: File report not found. Will search by url instead.
# WARN  main/vim: Url report not found. Will submit https://github.com/vim/vim-win32-installer/releases/download/v9.2.0530/gvim_9.2.0530_x64_signed.zip
# WARN  main/vim: not found: you can manually submit https://github.com/vim/vim-win32-installer/releases/download/v9.2.0530/gvim_9.2.0530_x64_signed.zip
# EXIT CODE 4

# > ?
# WARN  main/vim: File report not found. Will search by url instead.
# WARN  main/vim: Url report not found. Will submit https://github.com/vim/vim-win32-installer/releases/download/v9.2.0538/gvim_9.2.0538_x64_signed.zip
# INFO  main/vim: Analysis in progress.
# EXIT CODE unknown

# > ?
# WARN  main/azure-cli: File report not found. Will search by url instead.
# INFO  main/azure-cli: Url report found.
# INFO  main/azure-cli: Related file report found.
# WARN  main/azure-cli: Manual file upload is required (instead of url submission) for https://github.com/Azure/azure-cli/releases/download/azure-cli-2.87.0/azure-cli-2.87.0-x64.zip
    
# > scoop virustotal openssl-light
# main/innounp: 0/60, see https://www.virustotal.com/gui/file/1439f8d9e24b19e7d0b31b9c427ba4533387522a370c39280f17d3371eb7febf
# WARN  main/openssl-light: 10/71, see https://www.virustotal.com/gui/file/539588b195f660e7fb32f2ed11e9d0c729ce71c975f89cc7f74b3b6e80e45f9e
# EXIT CODE 2

# > scoop virustotal sqlpackage
# Couldn't find manifest for 'sqlpackage'.
# EXIT CODE 1

# > scoop virustotal ripgrep; $LASTEXITCODE
# main/ripgrep: 0/67, see https://www.virustotal.com/gui/file/124510b94b6baa3380d051fdf4650eaa80a302c876d611e9dba0b2e18d87493a
# 0

$YesToAll = $false
$NoToAll  = $false

foreach ($Update in $ScoopUpdates) {
    $PSNativeCommandUseErrorActionPreference = $false
    & scoop virustotal $Update.Name --scan # --passthru
    $Code = $LASTEXITCODE
    $PSNativeCommandUseErrorActionPreference = $true

    switch ($Code) {
        0 { <# safe #> }
        2 { <# unsafe #> }
        default { <# manually submit, exception raised, manifest not found, misconfiguration, ... #> continue }
    }

    $ShouldContinue = $PSCmdlet.ShouldContinue(
        "Update?",
        "$($Update.Name) $($Update.OldVersion) -> $($Update.NewVersion) ($($Update.Source))",
        $true, # has security impact
        [ref] $YesToAll,
        [ref] $NoToAll
    )

    if ($ShouldContinue) {
        & scoop update $Update.Name
    }
}

#------------------------------------------------------------------------------
Write-Host "Checking WinGet against VirusTotal" @FromMe

$YesToAll = $false
$NoToAll  = $false

foreach ($Update in $WinGetUpdates) {
    $Info = & winget show --id $Update.Id 2>&1 | Out-String

    if ($Info -match '\b(?i)Installer Url: ([^\r\n]+)') {
        $InstallerUrl = $Matches[1]
    } else {
        $InstallerUrl = $null
    }

    if ($Info -match '\b(?i)Installer SHA256: ([^\r\n]+)') {
        # NOTE: VirusTotal accepts SHA-256, SHA-1, and MD5
        $InstallerHash = $Matches[1]
    } else {
        $InstallerHash = $null
    }

    $Vt = $null

    if ($InstallerHash) {
        $VtRaw = & vt file $InstallerHash --format json 2>&1 | Out-String
        # Possible outcomes:
        # - exit 1, stderr: error or help message
        # - exit 0, stderr: File "..." not found
        # - exit 0, no output (if unsupported hash)
        # - exit 0, stdout: [{...}]
        if ($VtRaw -like '[[]*') {
            $Vt = $VtRaw | ConvertFrom-Json -Depth 100 | Select-Object -First 1
        }
    }

    if (-not $Vt -and $InstallerUrl) {
        Write-Host "$($Update.Name): hash not found; submitting for analysis..."

        $TempFile = Join-Path $env:TEMP "$($Update.Id).tmp"
        try {
            Invoke-WebRequest -Uri $InstallerUrl -OutFile $TempFile
            $VtRaw = & vt scan file installer.tmp --wait --format json | Out-String
            if ($VtRaw -like '[[]*') {
                $Vt = $VtRaw | ConvertFrom-Json -Depth 100 | Select-Object -First 1
            }
        }
        finally {
            Remove-Item -LiteralPath $TempFile -Force -ErrorAction Ignore
        }
    }

    if (-not $Vt) {
        Write-Warning "$($Update.Name): failed to retrieve analysis"
        continue
    }

    $VtDate  = [DateTimeOffset]::FromUnixTimeSeconds($Vt.last_analysis_date).UtcDateTime
    $VtStats = $Vt.last_analysis_stats
    $VtLevel   = $VtStats.malicious  + $VtStats.suspicious
    $VtTotal = $VtStats.undetected + $VtStats.harmless + $VtLevel
    $VtFound = @(
        $Vt.last_analysis_results.PSObject.Properties.Value `
        | Where-Object category -In malicious, suspicious `
        | Select-Object engine_name, result
        # engine_name: MaxSecure
        # result:      Trojan.Malware.328990141.susgen
    )
    $Color `
        = $VtLevel -ge 5 ? 'Red'    `
        : $VtLevel       ? 'Yellow' `
        :                  'Green'
    Write-Host "$($Update.Name): $VtLevel/$VtTotal as of $VtDate" -ForegroundColor $Color
    if ($VtLevel) {
        Write-Host "  https://www.virustotal.com/gui/file/$InstallerHash" -ForegroundColor Red
    }
    foreach ($Detection in $VtFound) {
        Write-Host "  - ${Detection.engine_name}: ${Detection.result}"
    }

    $ShouldContinue = $PSCmdlet.ShouldContinue(
        "Update?",
        "$($Update.Name) $($Update.OldVersion) -> $($Update.NewVersion) ($($Update.Source))",
        $true, # has security impact
        [ref] $YesToAll,
        [ref] $NoToAll
    )

    if ($ShouldContinue) {
        & winget upgrade --id $Update.Id -i
    }
}
