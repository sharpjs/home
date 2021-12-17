#Requires -RunAsAdministrator

[CmdletBinding()]
param(
    [Parameter(Position=0)]
    [ValidateRange(0, 365)]
    [int]
    $DaysBack = 3
)

$CutoffDate = [DateTime]::UtcNow.AddDays(-$DaysBack)
$Locations  = Get-Item Temp:\, (Join-Path $env:SystemRoot Temp)

$Locations `
    | Get-ChildItem -Recurse -File `
    | Where-Object LastWriteTimeUtc -LT $CutoffDate `
    | Remove-Item -Force -ErrorAction SilentlyContinue -Verbose

$Locations `
    | Get-ChildItem -Recurse -Directory `
    | Sort-Object FullName -Descending `
    | Where-Object { $_.GetFileSystemInfos().Length -eq 0 } `
    | Remove-Item -Force -ErrorAction SilentlyContinue -Verbose
