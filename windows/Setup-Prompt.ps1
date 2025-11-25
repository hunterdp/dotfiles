<#
.SYNOPSIS
    Configures a Kali-style two-line prompt for PowerShell.
.DESCRIPTION
    Updates the current user's profile with a prompt function featuring:
    - Box-drawing characters
    - Color-coded Hostname (DarkMagenta) and Path (DarkCyan)
    - UTF-8 encoding compliance for PowerShell 5.1
#>

$ProfilePath = $PROFILE

# 1. Ensure the profile directory exists
$ProfileDir = Split-Path $ProfilePath -Parent
if (!(Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}

# 2. Define the Prompt Function
# Note: "Write-Host" is used here to allow multiple colors on the same line.
$NewPrompt = @'
function prompt {
    # Line 1: Corner bracket (DarkCyan)
    Write-Host "┌──" -NoNewline -ForegroundColor DarkCyan

    # Line 1: (HOSTNAME) (DarkMagenta)
    Write-Host "($env:COMPUTERNAME) " -NoNewline -ForegroundColor DarkMagenta

    # Line 1: Path (DarkCyan)
    Write-Host "$($PWD.Path)" -NoNewline -ForegroundColor DarkCyan
    
    # Line 2: Bottom line symbol
    return "`n└─$ "
}
'@

# 3. Write to file with UTF8 Encoding (Critical for the ┌ └ symbols)
try {
    Set-Content -Path $ProfilePath -Value $NewPrompt -Encoding UTF8 -Force
    Write-Host "SUCCESS: PowerShell profile updated." -ForegroundColor Green
    Write-Host "Run '. `$PROFILE' to load the new prompt immediately." -ForegroundColor Gray
}
catch {
    Write-Error "Failed to update profile: $_"
}
