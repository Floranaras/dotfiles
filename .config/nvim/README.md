# Neovim Configuration by Callo

This is a custom Neovim configuration primarily tailored for **C and C++ development**. It includes essential plugins for LSP support, autocompletion, automatic pairs, and a visually appealing theme.

## Features

* **LSP Support** for C/C++ via `clangd`
* **Autocompletion** with `nvim-cmp`
* **Auto pairs** via `nvim-autopairs`
* **Syntax highlighting** with `nvim-treesitter`
* **Modern theme** using `catppuccin`

## Theme
* The configuration uses the Rose Pine theme plugin for a natural and elegant color scheme:
* Plugin: rose-pine/neovim

## Installation

> Make sure you have Neovim 0.8+ and Git installed.

### 1. Backup existing config (optional but recommended)

```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

### 2. Clone this configuration

```sh
cd ~/.config
git clone https://github.com/CarlosRanara/nvim.git
```

### 3. Launch Neovim

```sh
nvim
```

Neovim will automatically install plugins on the first run (assuming lazy.nvim or packer is being used).

## Notes

* Ensure that `clangd` is installed and in your PATH:

  ```sh
  sudo apt install clangd  # Debian/Ubuntu
  sudo pacman -S clang     # Arch
  brew install llvm        # macOS (via Homebrew)
  choco install llvm       # Windows (via Chocolatey)
  scoop install llvm       # Windows (via Scoop)
  ```

* For full autocompletion, check the `nvim-cmp` setup in the `lua/callo/plugins/` directory.

## OS-Specific Setup

### Linux

* Most modern distros have `neovim` in their package manager:

  ```sh
  sudo apt install neovim          # Debian/Ubuntu
  sudo pacman -S neovim            # Arch
  sudo dnf install neovim          # Fedora
  ```

### Windows

* Install Neovim from the official site: [https://github.com/neovim/neovim/wiki/Installing-Neovim#windows](https://github.com/neovim/neovim/wiki/Installing-Neovim#windows)
* Place the config in:

  ```
  %USERPROFILE%\AppData\Local\nvim
  ```
* Use a terminal like [Windows Terminal](https://aka.ms/terminal) or [Alacritty](https://github.com/alacritty/alacritty)

### macOS

* Use Homebrew:

  ```sh
  brew install neovim
  ```
* Config location:

  ```sh
  ~/.config/nvim
  ```

## Recommended Fonts

For the best experience, use a **Nerd Font** like [MesloLGS NF](https://www.nerdfonts.com/font-downloads) to support devicons and UI symbols.

---
