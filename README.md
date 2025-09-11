# My Dotfiles - Hyprland Anime-Inspired Rice

> A beautiful, minimal, and expressive Hyprland setup themed around a serene anime night sky

This repository contains my personal configuration files (dotfiles) for various applications and tools I use. These configurations help me maintain a consistent and efficient working environment across different machines, with a focus on an **anime-style aesthetic** featuring deep blues, rich purples, and gentle pinks painting the horizon.

> Just something I did for fun with an old laptop a family member had — they got a new one, so I gave this machine a new life. It's running Arch Linux, by the way.

## Theme Overview

This setup embraces an **anime-style aesthetic** with a character gazing at a **stunning starry night sky**. It's designed for **beauty and clarity**, ideal for those who want a peaceful yet functional workspace.

* **Color Palette**: Deep blue, purple, subtle pink
* **Compositor**: [Hyprland](https://github.com/hyprwm/Hyprland)
* **Launcher**: Wofi with custom styling
* **Status Bar**: Waybar, clean and themed
* **Terminal**: Ghostty with custom configuration
* **Terminal Multiplexer**: Tmux with anime-themed styling
* **Editor**: Neovim with complete plugin setup and markdown preview
* **Shell**: Zsh with custom configuration
* **Wallpaper**: Managed by Hyprpaper

---

## Screenshot

### Desktop Overview
![Screenshot](images/screenshot.png)

---

## What's Included

- **Hyprland**: Wayland compositor configuration with custom keybinds, window rules, and animations
- **Waybar**: Status bar configuration with anime-themed styling
- **Wofi**: Application launcher with custom styling to match the theme
- **Ghostty**: Modern terminal emulator configuration
- **Tmux**: Terminal multiplexer with custom styling and keybinds matching the anime theme
- **Neovim**: Complete editor setup with LSP, plugins, markdown preview, and custom keymaps
- **Zsh**: Shell configuration and customizations

## Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Applications
- **stow**: Symbolic link farm manager for dotfile management
- **Hyprland**: Dynamic tiling Wayland compositor
- **hyprpaper**: Wallpaper utility for Hyprland
- **Waybar**: Highly customizable Wayland bar
- **Wofi**: Application launcher for wlroots-based compositors
- **Ghostty**: Fast, feature-rich terminal emulator
- **Tmux**: Terminal multiplexer
- **Neovim ≥ 0.10**: Hyperextensible Vim-based text editor
- **Zsh**: Extended Bourne shell
- **Git**: Version control system
- **Node.js & npm**: JavaScript runtime for LSP servers
- **Nerd Font**: For proper icon display (JetBrains Mono Nerd Font recommended)

### Neovim-Specific Dependencies
- **glow**: Terminal-based markdown renderer
- **ripgrep**: Fast search tool for Telescope
- **unzip**: For plugin installations
- **Python3**: For some LSP servers
- **clangd**: C/C++ language server
- **Java JDK**: For Java development (optional)

### Additional Dependencies
- **For Waybar**: Nerd Font symbols for proper icon display

> **Platform-specific installation instructions**: See the [Installation Guide](#installation-guide) section below for detailed commands for your operating system.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Floranaras/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install prerequisites** (see [Installation Guide](#installation-guide) below)

3. **Use stow to create symbolic links:**
   ```bash
   # Install individual configurations
   stow hypr waybar wofi ghostty tmux nvim zsh
   
   # Or install everything at once
   stow */
   ```

4. **First-time setup:**
   ```bash
   # Reload Hyprland
   hyprctl reload
   
   # Reload Tmux config (if already running)
   tmux source-file ~/.tmux.conf
   
   # Restart Waybar (if already running)
   killall waybar && waybar &
   
   # Open Neovim to auto-install plugins
   nvim
   # Run :Lazy sync if plugins don't auto-install
   ```

## Configuration Structure

```bash
.
├── ghostty/      # Ghostty terminal configuration
├── hypr/         # Hyprland configuration files
├── images/       # Screenshot
├── nvim/         # Complete Neovim setup with plugins and markdown preview
├── tmux/         # Tmux configuration with anime theme
├── waybar/       # Waybar config and anime-themed styling
├── wofi/         # Wofi config and custom styling
└── zsh/          # Zsh configuration
```

## Installation Guide

<details>
<summary><strong> Arch Linux</strong></summary>

```bash
# Core dependencies
sudo pacman -S stow unzip python python-pip clang tmux neovim zsh git nodejs npm ripgrep

# Glow for markdown preview
sudo pacman -S glow

# Nerd fonts for Waybar and terminal
sudo pacman -S ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono-nerd

# Hyprland ecosystem (if not already installed)
sudo pacman -S hyprland hyprpaper waybar wofi

# Ghostty (from AUR)
yay -S ghostty
# or
paru -S ghostty

# Java (optional, for Java development)
sudo pacman -S jdk-openjdk
```
</details>

<details>
<summary><strong> Debian/Ubuntu</strong></summary>

```bash
# Core dependencies
sudo apt update
sudo apt install stow unzip python3 python3-pip clangd tmux neovim zsh git nodejs npm

# Ripgrep for Telescope
sudo apt install ripgrep

# Glow for markdown preview (install from GitHub releases)
curl -s https://api.github.com/repos/charmbracelet/glow/releases/latest | grep browser_download_url | grep linux_amd64.deb | cut -d '"' -f 4 | wget -qi -
sudo dpkg -i glow_*_linux_amd64.deb

# Nerd fonts
sudo apt install fonts-nerd-font-jetbrainsmono

# Java (optional)
sudo apt install default-jdk

# Note: Hyprland, Waybar, Wofi, and Ghostty may need to be installed 
# from their respective repositories or built from source
```
</details>

<details>
<summary><strong> Fedora/RHEL/CentOS</strong></summary>

```bash
# Core dependencies
sudo dnf install stow unzip python3 python3-pip clang-tools-extra tmux neovim zsh git nodejs npm ripgrep

# Glow (install from GitHub releases)
sudo dnf install https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.rpm

# For Nerd fonts
sudo dnf install jetbrains-mono-fonts

# Java (optional)
sudo dnf install java-17-openjdk-devel

# Note: Hyprland ecosystem may need to be installed from source
```
</details>

<details>
<summary><strong> openSUSE</strong></summary>

```bash
# Core dependencies
sudo zypper install stow unzip python3 python3-pip clang-tools tmux neovim zsh git nodejs npm

# Ripgrep
sudo zypper install ripgrep

# Glow (install from GitHub releases)
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.rpm
sudo rpm -i glow_1.5.1_linux_amd64.rpm

# Fonts
sudo zypper install jetbrains-mono-fonts

# Java (optional)
sudo zypper install java-17-openjdk-devel
```
</details>

<details>
<summary><strong> Alpine Linux</strong></summary>

```bash
# Core dependencies
sudo apk add stow unzip python3 py3-pip clang-extra-tools tmux neovim zsh git nodejs npm

# Ripgrep
sudo apk add ripgrep

# Glow (install from GitHub releases)
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.apk
sudo apk add --allow-untrusted glow_1.5.1_linux_amd64.apk

# Download Nerd fonts manually from nerdfonts.com

# Java (optional)
sudo apk add openjdk17
```
</details>

<details>
<summary><strong> Void Linux</strong></summary>

```bash
# Core dependencies
sudo xbps-install -S stow unzip python3 python3-pip clang-tools-extra tmux neovim zsh git nodejs npm ripgrep

# Glow
sudo xbps-install -S glow

# Fonts
sudo xbps-install -S font-jetbrains-mono

# Java (optional)
sudo xbps-install -S openjdk17
```
</details>

<details>
<summary><strong> Gentoo</strong></summary>

```bash
# Core dependencies
sudo emerge app-portage/stow app-arch/unzip dev-lang/python sys-devel/clang app-misc/tmux app-editors/neovim app-shells/zsh dev-vcs/git net-libs/nodejs sys-apps/ripgrep

# Glow
sudo emerge app-misc/glow

# Fonts
sudo emerge media-fonts/jetbrains-mono

# Java (optional)
sudo emerge virtual/jdk
```
</details>

<details>
<summary><strong> NixOS</strong></summary>

Add to your `configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  stow unzip python3 clang-tools tmux neovim zsh git nodejs npm ripgrep glow
  jetbrains-mono
  # Optional: jdk17
];
```

Or use `nix-env`:
```bash
nix-env -iA nixpkgs.stow nixpkgs.unzip nixpkgs.python3 nixpkgs.clang-tools nixpkgs.tmux nixpkgs.neovim nixpkgs.zsh nixpkgs.git nixpkgs.nodejs nixpkgs.npm nixpkgs.ripgrep nixpkgs.glow
```
</details>

<details>
<summary><strong> macOS</strong></summary>

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core dependencies
brew install stow python3 llvm tmux neovim zsh git node ripgrep glow

# Fonts (requires font cask)
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font

# Java (optional)
brew install openjdk

# Note: Hyprland is Linux-specific. Consider alternatives like yabai or Amethyst for tiling window management
```
</details>

<details>
<summary><strong> FreeBSD</strong></summary>

```bash
# Core dependencies
pkg install stow unzip python3 llvm tmux neovim zsh git node npm ripgrep

# Glow (may need to build from source)
pkg install go
go install github.com/charmbracelet/glow@latest

# Fonts
pkg install jetbrains-mono

# Java (optional)
pkg install openjdk17
```
</details>

<details>
<summary><strong> Windows</strong></summary>

**Option 1: WSL (Recommended)**
1. Install WSL2 and a Linux distribution:
   ```powershell
   wsl --install
   ```
2. Follow the Linux instructions for your chosen distro inside WSL

**Option 2: Native Windows**
```powershell
# Using winget (Windows Package Manager)
winget install Git.Git
winget install Python.Python.3
winget install OpenJS.NodeJS
winget install BurntSushi.ripgrep.MSVC
winget install JetBrains.JetBrainsMono.NerdFont

# Glow
winget install charmbracelet.glow

# Java (optional)
winget install Microsoft.OpenJDK.17

# Neovim
winget install Neovim.Neovim

# Note: You'll need a package manager like Scoop or Chocolatey for some tools:
# Install Scoop first:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Then install missing tools:
scoop install stow
```

**Option 3: MSYS2/MinGW**
```bash
# Install MSYS2 first from https://www.msys2.org/
# Then in MSYS2 terminal:
pacman -S mingw-w64-x86_64-stow mingw-w64-x86_64-python mingw-w64-x86_64-nodejs mingw-w64-x86_64-tmux

# Note: Hyprland is not available on Windows. Consider PowerToys FancyZones or similar
```
</details>

## Configuration Highlights

### Neovim
- **Complete LSP setup** with automatic server installation via Mason
- **Cross-platform configuration** that works on macOS, Linux, and Windows
- **Language support**: C/C++ (clangd), Lua (lua_ls), Java (jdtls - cross-platform)
- **Smart completion** with nvim-cmp and snippet support
- **Fuzzy finding** with Telescope for files and live grep
- **Git integration** with vim-fugitive
- **File navigation** with Harpoon for quick file switching
- **Syntax highlighting** with Treesitter
- **Markdown preview** with Glow for beautiful terminal-based rendering
- **Undo history** with undotree visualization
- **Auto-pairs** for brackets and quotes
- **Custom keymaps** optimized for productivity
- **Rose Pine theme** with transparent background
- **Automatic plugin management** with lazy.nvim

#### Neovim Key Features:
- **`<space>pf`** - Find files with Telescope
- **`<space>ps`** - Live grep search
- **`<space>gs`** - Git status with Fugitive  
- **`<space>a`** - Add file to Harpoon
- **`<C-e>`** - Toggle Harpoon quick menu
- **`<space>md`** - Markdown preview with Glow (press `q` to exit)
- **`<space>u`** - Toggle undo tree
- **`gd`** - Go to definition (LSP)
- **`K`** - Hover documentation (LSP)
- **`<space>vca`** - Code actions (LSP)
- **`<space>vrn`** - Rename symbol (LSP)
- **`<space>f`** - Format code (LSP)

#### Markdown Preview:
The configuration includes **Glow** for beautiful terminal-based markdown preview that renders GitHub-style markdown directly in Neovim. Simply open any `.md` file and use `<space>md` or `:Glow` to see a formatted preview with syntax highlighting, proper headers, lists, and code blocks. The preview appears in the same terminal window - press `q` to return to editing.

#### Plugin Management:
Uses **lazy.nvim** for fast, modern plugin management with lazy loading. Plugins are automatically installed on first launch, and the configuration is designed to work across different operating systems without manual path adjustments.

### Tmux
- Custom status bar styling matching the anime theme
- Optimized keybinds for productivity
- Beautiful pane borders and window indicators

### Waybar
- Anime-themed styling with deep blues and purples
- Custom modules for system monitoring
- Requires Nerd Font symbols for proper icons

### Ghostty & Zsh
- Modern terminal with custom styling
- Enhanced shell experience with productivity features

## Troubleshooting

**Check symbolic links:**
```bash
ls -la ~/.config/{hypr,nvim,waybar,wofi,ghostty} ~/.tmux.conf ~/.zshrc
```

**For Neovim issues:**
```bash
# Run health checks
nvim -c ":checkhealth"

# Check if plugins are installed
nvim -c ":Lazy"

# Common issues: missing glow, unzip, Python3, or clangd
```

**For markdown preview issues:**
```bash
# Check if glow is installed
glow --version

# Test glow directly
glow README.md
```

**For Hyprland issues:**
```bash
journalctl -f --user-unit hyprland
```

**For Tmux issues:**
```bash
tmux show-options -g
```

## Final Thoughts

This rice is meant to offer a calm, elegant workspace — inspired by anime visuals and cosmic beauty. Whether you're coding, managing multiple terminal sessions, writing markdown documentation, or vibing with lofi, this desktop is your new starry refuge.

The Neovim configuration is designed to be portable and work across different operating systems, with automatic plugin installation and a beautiful markdown preview system that renders directly in the terminal.

> "Even the darkest nights will end, and the stars will shine again." ✨

### Contact / Credit
Crafted with love by **Callo**

## Contributing

If you have suggestions for improvements or find any issues, feel free to open an issue or submit a pull request.

## License

This repository is available under the MIT License. Feel free to use and modify these configurations for your own setup.
