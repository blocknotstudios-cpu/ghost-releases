# Ghost License System - Automated Installer
# This script runs directly from the web without downloading first

param(
    [Parameter(Mandatory=$false)]
    [string]$GhostUrl = "",
    
    [Parameter(Mandatory=$false)]
    [string]$KeygenUrl = "https://drive.google.com/uc?export=download&id=1ygkcW7fZ4KyxzFIRZN94VG5n8zHeYkhF"
)

# If URLs not provided as parameters, use these defaults
if ([string]::IsNullOrEmpty($GhostUrl)) {
    $GhostUrl = "https://github.com/blocknotstudios-cpu/ghost-releases/raw/main/ghost.exe"
}
if ([string]::IsNullOrEmpty($KeygenUrl)) {
    $KeygenUrl = "https://github.com/blocknotstudios-cpu/ghost-releases/raw/main/keygen.exe"
}

# Banner
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "     Ghost License System Installer    " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create installation directory
$installPath = "$env:USERPROFILE\AppData\Local\Ghost"
Write-Host "[*] Creating installation directory..." -ForegroundColor Yellow
if (-Not (Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath -Force | Out-Null
}

# Download ghost.exe
Write-Host "[*] Downloading ghost.exe..." -ForegroundColor Yellow
try {
    $ghostPath = "$installPath\ghost.exe"
    Invoke-WebRequest -Uri $GhostUrl -OutFile $ghostPath -UseBasicParsing
    Write-Host "[+] ghost.exe downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "[!] Failed to download ghost.exe: $_" -ForegroundColor Red
    exit 1
}

# Download keygen.exe
Write-Host "[*] Downloading keygen.exe..." -ForegroundColor Yellow
try {
    $keygenPath = "$installPath\keygen.exe"
    Invoke-WebRequest -Uri $KeygenUrl -OutFile $keygenPath -UseBasicParsing
    Write-Host "[+] keygen.exe downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "[!] Failed to download keygen.exe: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "     Installation Complete!            " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Files installed to: $installPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "     SETUP INSTRUCTIONS                " -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "STEP 1: Generate Your License Key" -ForegroundColor White
Write-Host "-----------------------------------" -ForegroundColor Gray
Write-Host "Run this command:" -ForegroundColor Cyan
Write-Host "  cmd /c `"$keygenPath`" ghost-keygen" -ForegroundColor White
Write-Host ""
Write-Host "This will:" -ForegroundColor Gray
Write-Host "  • Generate a 3-day trial key locked to your PC" -ForegroundColor Gray
Write-Host "  • Automatically copy the key to your clipboard" -ForegroundColor Gray
Write-Host "  • Display key expiration date" -ForegroundColor Gray
Write-Host ""

Write-Host "STEP 2: Launch Ghost" -ForegroundColor White
Write-Host "-----------------------------------" -ForegroundColor Gray
Write-Host "Run this command:" -ForegroundColor Cyan
Write-Host "  cmd /c `"$ghostPath`" ghost-activate" -ForegroundColor White
Write-Host ""
Write-Host "This will:" -ForegroundColor Gray
Write-Host "  • Open the Ghost authentication window" -ForegroundColor Gray
Write-Host "  • Prompt you to enter your license key" -ForegroundColor Gray
Write-Host ""

Write-Host "STEP 3: Authenticate" -ForegroundColor White
Write-Host "-----------------------------------" -ForegroundColor Gray
Write-Host "  • Paste your license key (Ctrl+V)" -ForegroundColor Gray
Write-Host "  • Click 'AUTHENTICATE'" -ForegroundColor Gray
Write-Host "  • Ghost will verify and activate" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "     QUICK START COMMANDS              " -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Generate Key:" -ForegroundColor Cyan
Write-Host "  cmd /c `"$keygenPath`" ghost-keygen" -ForegroundColor White
Write-Host ""
Write-Host "Launch Ghost:" -ForegroundColor Cyan
Write-Host "  cmd /c `"$ghostPath`" ghost-activate" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")