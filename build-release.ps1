# PowerShell script to build NetworkSkins and create a release package

param(
    [string]$Version = "dev",
    [string]$OutputDir = ".\release"
)

Write-Host "Building NetworkSkins v$Version..." -ForegroundColor Cyan

# Clean previous build
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
if (Test-Path $OutputDir) {
    Remove-Item $OutputDir -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

# Build the project
Write-Host "Building project..." -ForegroundColor Yellow
dotnet build NetworkSkins\NetworkSkins.csproj -c Release

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

# Copy files to release directory
Write-Host "Copying files to release directory..." -ForegroundColor Yellow

$binPath = "NetworkSkins\bin\Release\net35"

# Copy main DLL
Copy-Item "$binPath\NetworkSkins.dll" $OutputDir

# Copy dependencies
if (Test-Path "$binPath\CitiesHarmony.API.dll") {
    Copy-Item "$binPath\CitiesHarmony.API.dll" $OutputDir
}

# Copy locale files
if (Test-Path "$binPath\Locale") {
    Copy-Item "$binPath\Locale" $OutputDir -Recurse
}

# Create ZIP archive
$zipName = "NetworkSkins-$Version.zip"
Write-Host "Creating archive: $zipName..." -ForegroundColor Yellow

if (Test-Path $zipName) {
    Remove-Item $zipName -Force
}

Compress-Archive -Path "$OutputDir\*" -DestinationPath $zipName

Write-Host "`nBuild complete!" -ForegroundColor Green
Write-Host "Release files are in: $OutputDir" -ForegroundColor Green
Write-Host "Release archive: $zipName" -ForegroundColor Green

# Show file list
Write-Host "`nRelease contents:" -ForegroundColor Cyan
Get-ChildItem $OutputDir -Recurse | ForEach-Object {
    Write-Host "  $($_.FullName.Replace($PWD, '.'))" -ForegroundColor Gray
}
