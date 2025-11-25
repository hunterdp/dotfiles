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

### PowerShell Prompt
Location: windows/Setup-Prompt.ps1

This script configures the current user's PowerShell profile to use the custom 2-line prompt with specific coloring (Dark Cyan for path, Dark Magenta for hostname).

### Installation: Run the setup script from the repository root:
```code
.\windows\Setup-Prompt.ps1
. $PROFILE
```

Note: This script enforces UTF-8 encoding to ensure the box-drawing characters (┌, └) render correctly in PowerShell 5.1.

### Command Prompt (CMD)
Location: windows/Setup-Prompt.bat

This batch file sets a permanent Windows Environment Variable (PROMPT) using ANSI escape codes to achieve the colored output in the standard command shell.

```code Installation: Run the batch file once:
.\windows\Setup-Prompt.bat
```

Note: You must restart your Command Prompt window for the changes to take effect.

Requirements
Font: A Nerd Font or modern monospace font (e.g., Cascadia Code, Consolas) is required to see the glyphs correctly.

Terminal: Windows Terminal (recommended), PowerShell 5.1+, or CMD on Windows 10/11.
