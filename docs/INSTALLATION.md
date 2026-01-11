# Installation Guide

## Prerequisites

Required for all setups:
- Git
- GNU Stow
- Neovim 0.10+
- Node.js & npm
- ripgrep
- fd
- bat
- deno

## Arch Linux

```bash
# Base packages
sudo pacman -S git stow neovim nodejs npm ripgrep fd bat

# Deno (for markdown preview)
curl -fsSL https://deno.land/install.sh | sh

# LSP servers (install via Mason in Neovim)
# C/C++: clangd via :Mason
# Lua: lua-language-server via :Mason

# Optional: JDK for Java development
sudo pacman -S jdk-openjdk
```

## Linux Mint

```bash
# Base packages
sudo apt update
sudo apt install git stow neovim nodejs npm ripgrep fd-find bat

# Fix bat/fd naming conflicts
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat

# Deno
curl -fsSL https://deno.land/install.sh | sh

# Optional: Latest Neovim (if apt version is old)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

## Fedora

```bash
# Base packages
sudo dnf install git stow neovim nodejs npm ripgrep fd-find bat

# Deno
curl -fsSL https://deno.land/install.sh | sh

# Optional: JDK for Java
sudo dnf install java-latest-openjdk java-latest-openjdk-devel
```

## macOS

```bash
# Install Homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Base packages
brew install git stow neovim node ripgrep fd bat deno

# Optional: Java
brew install openjdk
```

## Windows (WSL)

```bash
# Install WSL2 with Ubuntu first
wsl --install

# Then follow Linux Mint instructions
sudo apt update
sudo apt install git stow neovim nodejs npm ripgrep fd-find bat

# Fix naming conflicts
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat

# Deno
curl -fsSL https://deno.land/install.sh | sh
```

## Post-Install

```bash
# Clone dotfiles
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Symlink configs
stow nvim zsh tmux ghostty

# Start Neovim (plugins auto-install)
nvim

# Wait for lazy.nvim to install plugins
# Then run health checks
:checkhealth
:checkhealth telescope
:Mason  # Install LSP servers as needed
```

## Language Servers

Install via `:Mason` in Neovim:

- **C/C++**: clangd
- **Lua**: lua-language-server
- **Java**: jdtls (requires JDK)
- **Python**: pyright
- **JavaScript/TypeScript**: tsserver

## Optional Tools

```bash
# Database tools (if using dadbod)
# MySQL
brew install mysql      # macOS
sudo apt install mysql  # Linux

# PostgreSQL
brew install postgresql      # macOS
sudo apt install postgresql  # Linux
```
