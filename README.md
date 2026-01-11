# Dotfiles

Personal configuration files for Neovim, Zsh, Tmux, and Ghostty.

## Quick Start

```bash
# Clone repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install prerequisites (see links below)
# Then symlink configs
stow nvim zsh tmux ghostty
```

## Prerequisites

Install required packages for your OS:

- [Arch Linux](docs/INSTALLATION.md#arch-linux)
- [Linux Mint](docs/INSTALLATION.md#linux-mint)
- [Fedora](docs/INSTALLATION.md#fedora)
- [macOS](docs/INSTALLATION.md#macos)
- [Windows (WSL)](docs/INSTALLATION.md#windows-wsl)

## What's Included

- **Neovim** - LSP, Treesitter, fuzzy finding, database tools ([details](docs/NEOVIM.md))
- **Zsh** - Shell configuration
- **Tmux** - Terminal multiplexer
- **Ghostty** - Terminal emulator config
- **Vencord Theme** - Custom Discord Theme 

## Documentation

- [Installation Guide](docs/INSTALLATION.md) - OS-specific prerequisites
- [Neovim Setup](docs/NEOVIM.md) - Features, keybindings, plugins
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues and fixes

## Updating

```bash
cd ~/.dotfiles
git pull
stow --restow nvim zsh tmux ghostty
```

## Uninstalling

```bash
cd ~/.dotfiles
stow -D nvim zsh tmux ghostty
```
