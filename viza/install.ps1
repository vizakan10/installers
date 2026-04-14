param(
  [string]$Version = "latest",
  [switch]$AddToPath = $true
)

$ErrorActionPreference = "Stop"
# $ProgressPreference = "SilentlyContinue"


$manifestUrl = "https://raw.githubusercontent.com/vizakan10/installers/main/viza/manifest.json"
$manifest = (Invoke-WebRequest -UseBasicParsing -Uri $manifestUrl).Content | ConvertFrom-Json

$installDir = $manifest.installDir.Replace("%LOCALAPPDATA%", $env:LOCALAPPDATA)
$exePath = Join-Path $installDir $manifest.exeName

Write-Host "[VIZA] Install dir: $installDir"
New-Item -ItemType Directory -Force -Path $installDir | Out-Null

# TODO: Once you publish releases, replace manifest URLs with real ones.
$downloadUrl = $manifest.downloadUrl
$shaUrl = $manifest.sha256Url

if ($downloadUrl -like "REPLACE_ME*") {
  throw "Manifest downloadUrl/sha256Url not set yet. Publish a release asset first, then update viza\manifest.json."
}

$tmpExe = Join-Path $env:TEMP "viza.exe"
$tmpSha = Join-Path $env:TEMP "viza.exe.sha256"

Write-Host "[VIZA] Downloading EXE..."
curl.exe -#" -L -o $tmpExe $downloadUrl

Write-Host "[VIZA] Downloading checksum..."
curl.exe -s -L -o $tmpSha $shaUrl

$expected = (Get-Content $tmpSha -Raw).Trim().Split(" ")[0]
$actual = (Get-FileHash $tmpExe -Algorithm SHA256).Hash.ToLower()

if ($expected.ToLower() -ne $actual) {
  throw "SHA256 mismatch. Expected $expected, got $actual"
}

Copy-Item -Force $tmpExe $exePath
Write-Host "[VIZA] Installed: $exePath"

if ($AddToPath) {
  $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
  if ($userPath -notlike "*$installDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$installDir", "User")
    Write-Host "[VIZA] Added to User PATH. Open a new terminal."
  }
}

Write-Host "[VIZA] Done. Try: viza --version"
