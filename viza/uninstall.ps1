param(
  [switch]$RemoveUserData = $true,
  [switch]$RemoveFromPath = $true
)

$ErrorActionPreference = "SilentlyContinue"

$installDir = Join-Path $env:LOCALAPPDATA "Viza"
$exePath = Join-Path $installDir "viza.exe"

Remove-Item -Force $exePath
Remove-Item -Force (Join-Path $env:USERPROFILE ".viza_error.log")
if ($RemoveUserData) {
  Remove-Item -Recurse -Force (Join-Path $env:USERPROFILE ".viza")
}

if ($RemoveFromPath) {
  $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
  $parts = $userPath -split ';' | Where-Object { $_ -and ($_ -ne $installDir) }
  [Environment]::SetEnvironmentVariable("Path", ($parts -join ';'), "User")
}

Write-Host "[VIZA] Uninstalled. Open a new terminal."
