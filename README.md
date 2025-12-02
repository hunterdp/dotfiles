# My Dotfiles

This repository contains my personal dotfiles for various applications.

## What are dotfiles?

Dotfiles are configuration files for various programs on Unix-like systems. They are called "dotfiles" because their filenames usually start with a dot (`.`), which makes them hidden from normal directory listings.

## Included Configurations

This repository includes configurations for the following programs:

*   **Bash:** `~/.bashrc`, `~/.bash_profile`, `~/.bash_aliases`, `~/.bash_prompt`, `~/.profile`
*   **Git:** `~/.gitconfig`
*   **Neofetch:** `~/.config/neofetch/config.conf`
*   **Conky:** `~/.conkyrc`, `~/.conkyrc-nvidia`
*   **SSH:** `~/ssh_config.public`

## Neofetch Configuration

The `neofetch` configuration is customized to display the following information:

*   **Title:** Fully qualified domain name is shown.
*   **Kernel:** The full kernel string is shown.
*   **Distro:** The full distro name is shown.
*   **OS Architecture:** The OS architecture is shown.
*   **Uptime:** Uptime is shown in a shortened format.
*   **Memory:** Memory usage is shown as a percentage and in GiB.
*   **Packages:** Package manager names are shown.
*   **Shell:** The path and version of the shell are shown.
*   **CPU:** CPU temperature is shown in Fahrenheit.
*   **Public IP:** The public IP is fetched from `http://ident.me`.
*   **Color Blocks:** Color blocks are disabled.

## Windows Terminal Configuration

Custom configuration for Windows PowerShell and Command Prompt (cmd.exe) to mimic the Kali Linux style layout.

**Preview:**
```text
┌──(HOSTNAME) C:\Current\Path
└─$
```

### PowerShell Prompt (PowerShell 5.1 & 7+)
**Location:** `windows/Setup-Prompt-Clean.ps1`

This script configures **both PowerShell 5.1 and PowerShell 7+** profiles simultaneously:
- Creates a shared prompt function file in `AppData\Local\PowerShellPrompt\prompt.ps1`
- Updates profile files in local Documents folder to source the shared configuration
- Uses Unicode escape sequences for box-drawing characters (avoiding UTF-8 encoding issues)
- Automatically creates all necessary directories

**Colors:**
- Dark Cyan for box-drawing and path
- Dark Magenta for username@hostname

**Installation:**

Run the setup script from PowerShell (either version):
```powershell
.\windows\Setup-Prompt-Clean.ps1
```

Then close and reopen PowerShell (the profile loads automatically on startup).

**What it does:**
1. Creates `AppData\Local\PowerShellPrompt\prompt.ps1` with the shared prompt function
2. Creates/updates `Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` (PS 5.1)
3. Creates/updates `Documents\PowerShell\Microsoft.PowerShell_profile.ps1` (PS 7+)
4. Both profiles dot-source the shared prompt file

**Benefits:**
- Single source of truth for prompt configuration
- Works in both PowerShell versions automatically
- Easy to customize (edit one file, affects both versions)
- Avoids OneDrive sync conflicts by storing prompt in AppData\Local
- Bypasses Windows Security/Controlled Folder Access restrictions

**Troubleshooting:**

If you get an "Unauthorized changes blocked" popup:
1. Open **Windows Security** → **Virus & threat protection**
2. Click **Manage ransomware protection**
3. Click **Controlled folder access**
4. Click **Allow an app through Controlled folder access**
5. Add PowerShell executables:
   - `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe` (PS 5.1)
   - `C:\Program Files\PowerShell\7\pwsh.exe` (PS 7+, if installed)

Alternatively, the script stores the prompt file in `AppData\Local` which is typically not protected by Controlled Folder Access.

### Command Prompt (CMD)
**Location:** `windows/Setup-Prompt.bat`

This batch file sets a permanent Windows Environment Variable (PROMPT) using ANSI escape codes to achieve the colored output in the standard command shell.

**Installation:**

Run the batch file once:
```cmd
.\windows\Setup-Prompt.bat
```

**Note:** You must close and reopen Command Prompt for changes to take effect.

### Requirements

**Font:** A Nerd Font or modern monospace font (e.g., Cascadia Code, Consolas) is required to see the box-drawing characters correctly.

**Terminal:** Windows Terminal (recommended), PowerShell 5.1+, or CMD on Windows 10/11.

**Execution Policy:** The script will work with `LocalMachine` or `CurrentUser` set to `RemoteSigned` or `Unrestricted`. Check with:
```powershell
Get-ExecutionPolicy -List
```
