#Requires -Version 7.4 -RunAsAdministrator
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3

& SqlLocalDB.exe stop   ProjectModels
& SqlLocalDB.exe delete ProjectModels
& SqlLocalDB.exe stop
& SqlLocalDB.exe delete

Get-Item "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server Local DB" -ErrorAction Continue `
    | Rename-Item -NewName "Microsoft SQL Server Local DB.Disabled"

Get-Item "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server Local DB" -ErrorAction Continue `
    | Rename-Item -NewName "Microsoft SQL Server Local DB.Disabled"
