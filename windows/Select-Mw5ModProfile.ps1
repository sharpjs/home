[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory, Position = 0)]
    [string]
    $Name
)

begin {
    $ErrorActionPreference = "Stop"
    Set-StrictMode -Version 3.0
    Push-Location 'D:\SteamLibrary\steamapps\common\MechWarrior 5 Mercenaries\MW5Mercs\Mods'
}

process {
    if (Test-Path "modlist-$Name.json") {
        Copy-Item "modlist-$Name.json" -Destination "modlist.json" -Force `
            -WhatIf:$WhatIfPreference -Confirm:$ConfirmPreference
    }
    else {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                [System.IO.FileNotFoundException]::new("Mod profile '$Name' not found."),
                "ModProfileNotFound",
                [System.Management.Automation.ErrorCategory]::ObjectNotFound,
                $Name
            )
        )
    }
}

clean {
    Pop-Location
}
