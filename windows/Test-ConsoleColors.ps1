0..255 | ForEach-Object {
  Write-Host -NoNewline: ($_ % 8 -ne 7) (
    "`u{1B}[38;5;{0}m{0:D3} `u{1B}[48;5;{0}m   `u{1B}[0m  " -f $_
  )
}
