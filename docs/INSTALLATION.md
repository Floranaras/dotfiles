# Installation Guide

Complete installation instructions for all supported operating systems.

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
- **eza**: Modern replacement for ls with tree view and icons
- **Git**: Version control system
- **Node.js & npm**: JavaScript runtime for LSP servers
- **Nerd Font**: For proper icon display (JetBrains Mono Nerd Font recommended)

### Optional but Recommended
- **gradle**: Build automation tool for Java projects (for gradle aliases)
- **ctags**: Universal Ctags for code navigation

### Neovim-Specific Dependencies
- **glow**: Terminal-based markdown renderer
- **ripgrep**: Fast search tool for Telescope
- **unzip**: For plugin installations
- **Python3**: For some LSP servers
- **clangd**: C/C++ language server
- **Java JDK**: For Java development (optional)

### Additional Dependencies
- **For Waybar**: Nerd Font symbols for proper icon display

---

## Platform-Specific Installation

<details>
<summary><strong> Arch Linux</strong></summary>

```bash
# Core dependencies
sudo pacman -S stow unzip python python-pip clang tmux neovim zsh git nodejs npm ripgrep eza

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

# Optional development tools
sudo pacman -S gradle universal-ctags

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

# Eza (modern ls replacement)
# Add eza repository
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# Glow for markdown preview (install from GitHub releases)
curl -s https://api.github.com/repos/charmbracelet/glow/releases/latest | grep browser_download_url | grep linux_amd64.deb | cut -d '"' -f 4 | wget -qi -
sudo dpkg -i glow_*_linux_amd64.deb

# Nerd fonts
sudo apt install fonts-nerd-font-jetbrainsmono

# Optional development tools
sudo apt install gradle universal-ctags

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

# Eza (install from GitHub releases or build from source)
sudo dnf install https://github.com/eza-community/eza/releases/download/v0.17.0/eza-0.17.0-1.x86_64.rpm

# Glow (install from GitHub releases)
sudo dnf install https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.rpm

# For Nerd fonts
sudo dnf install jetbrains-mono-fonts

# Optional development tools
sudo dnf install gradle ctags

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

# Eza (install from GitHub releases)
wget https://github.com/eza-community/eza/releases/download/v0.17.0/eza-0.17.0-1.x86_64.rpm
sudo rpm -i eza-0.17.0-1.x86_64.rpm

# Glow (install from GitHub releases)
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.rpm
sudo rpm -i glow_1.5.1_linux_amd64.rpm

# Fonts
sudo zypper install jetbrains-mono-fonts

# Optional development tools
sudo zypper install gradle ctags

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

# Eza (build from source or install from GitHub releases)
wget https://github.com/eza-community/eza/releases/download/v0.17.0/eza_x86_64-unknown-linux-musl.tar.gz
tar xzf eza_x86_64-unknown-linux-musl.tar.gz
sudo mv eza /usr/local/bin/

# Glow (install from GitHub releases)
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_linux_amd64.apk
sudo apk add --allow-untrusted glow_1.5.1_linux_amd64.apk

# Download Nerd fonts manually from nerdfonts.com

# Optional development tools
sudo apk add gradle ctags

# Java (optional)
sudo apk add openjdk17
```
</details>

<details>
<summary><strong> Void Linux</strong></summary>

```bash
# Core dependencies
sudo xbps-install -S stow unzip python3 python3-pip clang-tools-extra tmux neovim zsh git nodejs npm ripgrep

# Eza
sudo xbps-install -S eza

# Glow
sudo xbps-install -S glow

# Fonts
sudo xbps-install -S font-jetbrains-mono

# Optional development tools
sudo xbps-install -S gradle ctags

# Java (optional)
sudo xbps-install -S openjdk17
```
</details>

<details>
<summary><strong> Gentoo</strong></summary>

```bash
# Core dependencies
sudo emerge app-portage/stow app-arch/unzip dev-lang/python sys-devel/clang app-misc/tmux app-editors/neovim app-shells/zsh dev-vcs/git net-libs/nodejs sys-apps/ripgrep

# Eza
sudo emerge sys-apps/eza

# Glow
sudo emerge app-misc/glow

# Fonts
sudo emerge media-fonts/jetbrains-mono

# Optional development tools
sudo emerge dev-util/gradle dev-util/ctags

# Java (optional)
sudo emerge virtual/jdk
```
</details>

<details>
<summary><strong> NixOS</strong></summary>

Add to your `configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  stow unzip python3 clang-tools tmux neovim zsh git nodejs npm ripgrep glow eza
  jetbrains-mono
  # Optional: gradle universal-ctags jdk17
];
```

Or use `nix-env`:
```bash
nix-env -iA nixpkgs.stow nixpkgs.unzip nixpkgs.python3 nixpkgs.clang-tools nixpkgs.tmux nixpkgs.neovim nixpkgs.zsh nixpkgs.git nixpkgs.nodejs nixpkgs.npm nixpkgs.ripgrep nixpkgs.glow nixpkgs.eza
```
</details>

<details>
<summary><strong> macOS</strong></summary>

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core dependencies
brew install stow python3 llvm tmux neovim zsh git node ripgrep glow eza

# Fonts (requires font cask)
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font

# Optional development tools
brew install gradle universal-ctags

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

# Eza (may need to build from source)
pkg search eza || cargo install eza

# Glow (may need to build from source)
pkg install go
go install github.com/charmbracelet/glow@latest

# Fonts
pkg install jetbrains-mono

# Optional development tools
pkg install gradle ctags

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

# Eza (install from GitHub releases)
# Download from https://github.com/eza-community/eza/releases

# Java (optional)
winget install Microsoft.OpenJDK.17

# Neovim
winget install Neovim.Neovim

# Note: You'll need a package manager like Scoop or Chocolatey for some tools:
# Install Scoop first:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Then install missing tools:
scoop install stow gradle
```

**Option 3: MSYS2/MinGW**
```bash
# Install MSYS2 first from https://www.msys2.org/
# Then in MSYS2 terminal:
pacman -S mingw-w64-x86_64-stow mingw-w64-x86_64-python mingw-w64-x86_64-nodejs mingw-w64-x86_64-tmux

# Note: Hyprland is not available on Windows. Consider PowerToys FancyZones or similar
```
</details>

---

## Post-Installation Setup

After installing all dependencies:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Floranaras/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Use stow to create symbolic links:**
   ```bash
   # Install individual configurations
   stow hypr waybar wofi ghostty tmux nvim zsh
   
   # Or install everything at once
   stow */
   ```

3. **First-time setup:**
   ```bash
   # Reload Hyprland
   hyprctl reload
   
   # Reload shell configuration
   source ~/.zshrc
   
   # Reload Tmux config (if already running)
   tmux source-file ~/.tmux.conf
   
   # Restart Waybar (if already running)
   killall waybar && waybar &
   
   # Open Neovim to auto-install plugins
   nvim
   # Run :Lazy sync if plugins don't auto-install
   ```

## Verification

Test that everything is working:

```bash
# Test shell aliases
l
ls
ll

# Test eza directly
eza --version

# Test Neovim
nvim --version

# Test glow (for markdown preview)
glow --version

# Test gradle (if installed)
gradle --version
```

If you encounter any issues, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for solutions.
