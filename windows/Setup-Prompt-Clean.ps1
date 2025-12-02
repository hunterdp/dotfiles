<#
.SYNOPSIS
    Configures a Kali-style two-line prompt for PowerShell 5.1 and 7+.
.DESCRIPTION
    Creates a shared prompt configuration that works across both PowerShell versions:
    - Box-drawing characters (┌, └)
    - Color-coded Hostname (DarkMagenta) and Path (DarkCyan)
    - UTF-8 encoding compliance
    - Shared prompt stored in AppData\Local (not OneDrive synced)
#>

# Paths
$LocalAppData = [Environment]::GetFolderPath('LocalApplicationData')
$DocumentsPath = [Environment]::GetFolderPath('MyDocuments')

$SharedPromptDir = "$LocalAppData\PowerShellPrompt"
$SharedPromptFile = "$SharedPromptDir\prompt.ps1"

$PS5ProfilePath = "$DocumentsPath\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$PS7ProfilePath = "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1"

Write-Host "Configuring Kali-style prompt for PowerShell..." -ForegroundColor Cyan
Write-Host "Shared prompt location: $SharedPromptDir" -ForegroundColor DarkGray

# Create shared prompt directory
if (!(Test-Path $SharedPromptDir)) {
    New-Item -ItemType Directory -Path $SharedPromptDir -Force | Out-Null
    Write-Host "Created directory: $SharedPromptDir" -ForegroundColor DarkGray
}

# Create shared prompt function using Unicode escape sequences
$PromptFunction = @'
function prompt {
    $topCorner = [char]0x250C + [char]0x2500 + [char]0x2500
    $bottomCorner = [char]0x2514 + [char]0x2500

    Write-Host $topCorner -NoNewline -ForegroundColor DarkCyan
    Write-Host "$env:USERNAME" -NoNewline -ForegroundColor DarkMagenta
    Write-Host "@($env:COMPUTERNAME) " -NoNewline -ForegroundColor DarkMagenta
    Write-Host "$($PWD.Path)" -NoNewline -ForegroundColor DarkCyan
    return "`n$bottomCorner`$ "
}
'@

# Write prompt file using .NET method for proper UTF-8 without BOM
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllLines($SharedPromptFile, $PromptFunction.Split("`n"), $utf8NoBom)
Write-Host "Created prompt file: $SharedPromptFile" -ForegroundColor Green

# Dot-source line for profiles
$SourceLine = ". `"$SharedPromptFile`""

# PowerShell 5.1 Profile
Write-Host ""
Write-Host "Configuring PowerShell 5.1 profile..." -ForegroundColor Cyan
$PS5Dir = Split-Path $PS5ProfilePath -Parent
if (!(Test-Path $PS5Dir)) {
    New-Item -ItemType Directory -Path $PS5Dir -Force | Out-Null
}

if (Test-Path $PS5ProfilePath) {
    $existingContent = Get-Content $PS5ProfilePath -Raw -ErrorAction SilentlyContinue
    if ($existingContent -notmatch [regex]::Escape($SourceLine)) {
        Add-Content -Path $PS5ProfilePath -Value "`n$SourceLine" -Encoding UTF8
        Write-Host "Updated PowerShell 5.1 profile" -ForegroundColor Green
    } else {
        Write-Host "PowerShell 5.1 profile already configured" -ForegroundColor Yellow
    }
} else {
    try {
        $SourceLine | Out-File -FilePath $PS5ProfilePath -Encoding UTF8 -Force
        Write-Host "Created PowerShell 5.1 profile" -ForegroundColor Green
    } catch {
        Write-Host "Warning: $_" -ForegroundColor Yellow
    }
}

# PowerShell 7+ Profile
Write-Host ""
Write-Host "Configuring PowerShell 7+ profile..." -ForegroundColor Cyan
$PS7Dir = Split-Path $PS7ProfilePath -Parent
if (!(Test-Path $PS7Dir)) {
    New-Item -ItemType Directory -Path $PS7Dir -Force | Out-Null
}

if (Test-Path $PS7ProfilePath) {
    $existingContent = Get-Content $PS7ProfilePath -Raw -ErrorAction SilentlyContinue
    if ($existingContent -notmatch [regex]::Escape($SourceLine)) {
        Add-Content -Path $PS7ProfilePath -Value "`n$SourceLine" -Encoding UTF8
        Write-Host "Created PowerShell 7+ profile" -ForegroundColor Green
    } else {
        Write-Host "PowerShell 7+ profile already configured" -ForegroundColor Yellow
    }
} else {
    try {
        $SourceLine | Out-File -FilePath $PS7ProfilePath -Encoding UTF8 -Force
        Write-Host "Created PowerShell 7+ profile" -ForegroundColor Green
    } catch {
        Write-Host "Warning: $_" -ForegroundColor Yellow
    }
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Shared prompt: $SharedPromptFile" -ForegroundColor White
Write-Host "PS 5.1 profile: $PS5ProfilePath" -ForegroundColor White
Write-Host "PS 7+ profile: $PS7ProfilePath" -ForegroundColor White
Write-Host ""
Write-Host "To activate now, run:" -ForegroundColor White
Write-Host '  . $PROFILE' -ForegroundColor Gray
Write-Host ""
