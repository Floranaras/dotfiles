# Shell Configuration Guide

Complete reference for shell aliases, functions, and productivity features.

## Overview

The Zsh configuration provides a modern, productive shell experience with:
- **Oh My Zsh** with robbyrussell theme
- **eza** for beautiful file listings with icons and tree views
- **Gradle development** shortcuts and project initialization
- **Rust and Java** environment integration
- **Custom PATH management** for various development tools

---

## File Navigation Aliases (eza)

Modern file listing with icons, colors, and tree views powered by [eza](https://github.com/eza-community/eza).

### Basic Listings

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --icons` | Simple list with icons |
| `ll` | `eza -lg --icons` | Detailed list with icons and file info |
| `la` | `eza -lag --icons` | All files (including hidden) with detailed info |

### Tree Views

| Alias | Command | Description |
|-------|---------|-------------|
| `l` | `eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=2` | Clean tree view, 2 levels deep |
| `lt` | `eza -lag --icons` | Tree view with detailed info |
| `lt1` | `eza -lag --level=1 --icons` | Tree view, 1 level deep |
| `lt2` | `eza -lag --level=2 --icons` | Tree view, 2 levels deep |
| `lt3` | `eza -lag --level=3 --icons` | Tree view, 3 levels deep |

### Example Usage

```bash
# Quick directory overview
l

# Detailed file information
ll

# Show hidden files and directories
la

# Deep tree exploration
lt3
```

### Eza Features

- **Icons**: File type icons using Nerd Fonts
- **Colors**: Syntax highlighting for file types
- **Git integration**: Shows git status in listings
- **Tree views**: Hierarchical directory visualization
- **File metadata**: Permissions, size, dates, ownership
- **Performance**: Fast and memory-efficient

---

## Development Aliases

### Gradle Development

| Alias | Command | Description |
|-------|---------|-------------|
| `grun` | `./gradlew run -q --console=plain` | Run Gradle project quietly |

### Functions

#### `ginit <project-name>`
Initialize a new Java project with Gradle.

**Usage:**
```bash
ginit helloWorld
# Creates Java project with package com.helloWorld
```

**Features:**
- Creates Gradle Java application structure
- Sets up package structure as `com.<project-name>`
- Includes validation and helpful usage messages
- Uses Gradle's built-in `init` task with Java application template

**Example:**
```bash
$ ginit myapp
Usage: ginit <project-name>
Example: ginit helloWorld
Creates Java project with package com.<project-name>

Creating Java project with package: com.myapp
```

### System Tools

| Alias | Command | Description |
|-------|---------|-------------|
| `ctags` | `/opt/homebrew/bin/ctags` | Use Homebrew ctags (macOS) |

---

## Environment Configuration

### PATH Management

The configuration includes optimized PATH management for:

```bash
# Java development
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Local binaries
export PATH="$PATH:$HOME/.local/bin"

# Rust toolchain
. "$HOME/.cargo/env"
```

### Terminal Configuration

```bash
# Ghostty terminal config
export GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
```

### Package Managers

```bash
# Created by pipx for Python packages
export PATH="$PATH:$HOME/.local/bin"
```

---

## Oh My Zsh Integration

### Theme
- **robbyrussell**: Clean, minimal theme showing git status and current directory

### Plugins
- **git**: Git aliases and functions for enhanced git workflow

### Git Integration
The git plugin provides numerous aliases. Some useful ones:
- `gst` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gl` - git pull
- `gco` - git checkout

---

## Shell Features

### Auto-completion
- Tab completion for commands, files, and directories
- Git branch and status completion
- Command history with search

### History Management
- Persistent command history
- History search with arrow keys
- Shared history across terminal sessions

### Prompt Information
- Current directory
- Git branch and status
- Clean, minimal design matching the anime theme

---

## Customization Examples

### Adding Your Own Aliases

Add to `~/.zshrc`:
```bash
# Custom development aliases
alias dev="cd ~/Development"
alias projects="cd ~/Projects"
alias serve="python3 -m http.server"

# Custom eza views
alias tree="eza --tree --level=3 --icons"
alias files="eza -la --sort=size --icons"
```

### Custom Functions

Add to `~/.zshrc`:
```bash
# Quick project creation
mkproject() {
    mkdir -p ~/Projects/$1
    cd ~/Projects/$1
    git init
    echo "# $1" > README.md
}

# Quick server startup
serve() {
    local port=${1:-8000}
    python3 -m http.server $port
}
```

---

## Troubleshooting

### Common Issues

**Eza not found:**
```bash
# Check if eza is installed
eza --version

# Install via package manager (see INSTALLATION.md)
# Arch: sudo pacman -S eza
# Ubuntu: follow eza installation steps
# macOS: brew install eza
```

**Icons not displaying:**
```bash
# Install a Nerd Font
# Arch: sudo pacman -S ttf-jetbrains-mono-nerd
# Ubuntu: sudo apt install fonts-nerd-font-jetbrainsmono
# macOS: brew install font-jetbrains-mono-nerd-font
```

**Gradle aliases not working:**
```bash
# Make sure you're in a Gradle project directory
ls -la | grep gradlew

# If gradlew doesn't exist, initialize project first
gradle init --type java-application
```

**Oh My Zsh not loaded:**
```bash
# Check Oh My Zsh installation
ls -la ~/.oh-my-zsh

# Reinstall if missing
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Alias Conflicts

If you have conflicting aliases:
```bash
# Check current aliases
alias | grep "alias-name"

# Unset an alias
unalias alias-name

# Check which command will be executed
which command-name
```

### Performance Issues

If shell startup is slow:
```bash
# Profile zsh startup
zsh -xvs

# Check what's taking time in .zshrc
time zsh -i -c exit
```

---

## Advanced Usage

### Combining with Other Tools

**With fzf (fuzzy finder):**
```bash
# If you have fzf installed
alias lf="eza --tree --level=3 | fzf"
```

**With git:**
```bash
# Enhanced git status with eza
alias gls="eza -la --git"
```

**File searching:**
```bash
# Combine with find
findfile() {
    find . -name "*$1*" -type f | head -20 | while read file; do
        eza -la "$file"
    done
}
```

### Integration with Other Configs

The shell configuration integrates seamlessly with:
- **Neovim**: File navigation and project management
- **Tmux**: Session and window management
- **Git**: Version control workflow
- **Hyprland**: Application launching and workspace management

For more details on these integrations, see:
- [NEOVIM.md](NEOVIM.md) - Editor configuration and workflow
- [CONFIGURATION.md](CONFIGURATION.md) - How all configs work together
