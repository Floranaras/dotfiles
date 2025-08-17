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
* **Editor**: Neovim with complete plugin setup
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
- **Neovim**: Complete editor setup with LSP, plugins, and custom keymaps
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
- **Neovim**: Hyperextensible Vim-based text editor
- **Zsh**: Extended Bourne shell
- **Nerd Font**: For proper icon display (JetBrains Mono Nerd Font recommended)

### Additional Dependencies
- **For Neovim**: unzip, Python3, clangd
- **For Waybar**: Nerd Font symbols

> ** Platform-specific installation instructions**: See the [Installation Guide](#installation-guide) section below for detailed commands for your operating system.

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
   ```

## Configuration Structure

```bash
.
├── ghostty/      # Ghostty terminal configuration
├── hypr/         # Hyprland configuration files
├── images/       # Screenshot
├── nvim/         # Complete Neovim setup with plugins
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
sudo pacman -S stow unzip python python-pip clang tmux neovim zsh

# Nerd fonts for Waybar
sudo pacman -S ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono-nerd

# Hyprland ecosystem (if not already installed)
sudo pacman -S hyprland hyprpaper waybar wofi

# Ghostty (from AUR)
yay -S ghostty
# or
paru -S ghostty
```
</details>

<details>
<summary><strong> Debian/Ubuntu</strong></summary>

```bash
# Core dependencies
sudo apt update
sudo apt install stow unzip python3 python3-pip clangd tmux neovim zsh

# Nerd fonts for Waybar
sudo apt install fonts-nerd-font-jetbrainsmono

# Note: Hyprland, Waybar, Wofi, and Ghostty may need to be installed 
# from their respective repositories or built from source
```
</details>

<details>
<summary><strong> Fedora/RHEL/CentOS</strong></summary>

```bash
# Core dependencies
sudo dnf install stow unzip python3 python3-pip clang-tools-extra tmux neovim zsh

# For Nerd fonts, download from nerdfonts.com or:
sudo dnf install jetbrains-mono-fonts

# Note: Hyprland ecosystem may need to be installed from source
```
</details>

<details>
<summary><strong> openSUSE</strong></summary>

```bash
# Core dependencies
sudo zypper install stow unzip python3 python3-pip clang-tools tmux neovim zsh

# For fonts
sudo zypper install jetbrains-mono-fonts
# Or download Nerd fonts from nerdfonts.com
```
</details>

<details>
<summary><strong> Alpine Linux</strong></summary>

```bash
# Core dependencies
sudo apk add stow unzip python3 py3-pip clang-extra-tools tmux neovim zsh

# Download Nerd fonts manually from nerdfonts.com
```
</details>

<details>
<summary><strong> Void Linux</strong></summary>

```bash
# Core dependencies
sudo xbps-install -S stow unzip python3 python3-pip clang-tools-extra tmux neovim zsh

# Fonts
sudo xbps-install -S font-jetbrains-mono
# Or download Nerd fonts from nerdfonts.com
```
</details>

<details>
<summary><strong> Gentoo</strong></summary>

```bash
# Core dependencies
sudo emerge app-portage/stow app-arch/unzip dev-lang/python sys-devel/clang app-misc/tmux app-editors/neovim app-shells/zsh

# Fonts
sudo emerge media-fonts/jetbrains-mono
# Or download Nerd fonts from nerdfonts.com
```
</details>

<details>
<summary><strong> NixOS</strong></summary>

Add to your `configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  stow unzip python3 clang-tools tmux neovim zsh
  jetbrains-mono
];
```

Or use `nix-env`:
```bash
nix-env -iA nixpkgs.stow nixpkgs.unzip nixpkgs.python3 nixpkgs.clang-tools nixpkgs.tmux nixpkgs.neovim nixpkgs.zsh
```
</details>

<details>
<summary><strong> macOS</strong></summary>

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core dependencies
brew install stow python3 llvm tmux neovim zsh

# Fonts (requires font cask)
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font

# Note: Hyprland is Linux-specific. Consider alternatives like yabai or Amethyst
```
</details>

<details>
<summary><strong> FreeBSD</strong></summary>

```bash
# Core dependencies
pkg install stow unzip python3 llvm tmux neovim zsh

# Fonts
pkg install jetbrains-mono
# Or download Nerd fonts from nerdfonts.com
```
</details>

<details>
<summary><strong> Windows</strong></summary>

**Option 1: WSL (Recommended)**
1. Install WSL2 and a Linux distribution
2. Follow the Linux instructions for your chosen distro

**Option 2: Native Windows**
```powershell
# Using winget
winget install Python.Python.3
winget install JetBrains.JetBrainsMono.NerdFont

# Note: Most tools will need WSL, MSYS2, or manual installation
# Hyprland is not available on Windows
```
</details>

## Configuration Highlights

### Tmux
- Custom status bar styling matching the anime theme
- Optimized keybinds for productivity
- Beautiful pane borders and window indicators

### Neovim
- Complete plugin setup for development
- LSP configuration with clangd support
- Custom keymaps and anime-themed styling
- Auto-installs plugins on first launch

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

# Common issues: missing unzip, Python3, or clangd
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

This rice is meant to offer a calm, elegant workspace — inspired by anime visuals and cosmic beauty. Whether you're coding, managing multiple terminal sessions, or vibing with lofi, this desktop is your new starry refuge.

> "Even the darkest nights will end, and the stars will shine again." ✨

### Contact / Credit
Crafted with love by **Callo**

## Contributing

If you have suggestions for improvements or find any issues, feel free to open an issue or submit a pull request.

## License

This repository is available under the MIT License. Feel free to use and modify these configurations for your own setup.
