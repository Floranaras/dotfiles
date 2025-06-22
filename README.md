# My Dotfiles

This repository contains my personal configuration files (dotfiles) for various applications and tools I use. These configurations help me maintain a consistent and efficient working environment across different machines, with a focus on a modern Wayland-based desktop setup.

## What's Included

- **Hyprland**: Wayland compositor configuration with custom keybinds, window rules, and animations
- **Waybar**: Status bar configuration with custom styling and modules
- **Wofi**: Application launcher configuration and styling
- **Ghostty**: Modern terminal emulator configuration
- **Neovim**: Complete editor setup with LSP, plugins, and custom keymaps
- **Zsh**: Shell configuration and customizations

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **stow**: A symbolic link farm manager used to manage dotfiles. You can install it via your distribution's package manager:
  - Arch Linux: `sudo pacman -S stow`
  - Debian/Ubuntu: `sudo apt-get install stow`
  - Fedora: `sudo dnf install stow`
  - macOS: `brew install stow`

- **The applications themselves**: Make sure you have the relevant applications installed:
  - **Hyprland**: Dynamic tiling Wayland compositor
  - **Waybar**: Highly customizable Wayland bar
  - **Wofi**: Application launcher for wlroots-based compositors
  - **Ghostty**: Fast, feature-rich terminal emulator
  - **Neovim**: Hyperextensible Vim-based text editor
  - **Zsh**: Extended Bourne shell with improvements

## Installation

To set up these dotfiles, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/[your-username]/dotfiles.git ~/.dotfiles
   ```

2. **Navigate to the dotfiles directory:**
   ```bash
   cd ~/.dotfiles
   ```

3. **Use stow to create symbolic links:**
   For each application or configuration directory in this repository, use `stow` to create the necessary symbolic links in your home directory.

   **For Hyprland configuration:**
   ```bash
   stow hyprland
   ```
   This will link the Hyprland configuration files to `~/.config/hypr/`

   **For Neovim configuration:**
   ```bash
   stow nvim
   ```
   This will link the Neovim configuration to `~/.config/nvim/`

   **For Ghostty terminal:**
   ```bash
   stow ghostty
   ```
   This will link the Ghostty config to `~/.config/ghostty/`

   **For Zsh configuration:**
   ```bash
   stow zsh
   ```
   This will link zsh configuration files to your home directory

   **To install all configurations at once:**
   ```bash
   stow */
   ```

## Configuration Highlights

### Hyprland
- Custom window rules and workspace management
- Optimized animations and performance settings
- Integrated with Waybar and Wofi
- Custom wallpaper management with hyprpaper
- Screenshot utilities and keybinds

### Neovim
- Lazy.nvim plugin manager setup
- LSP configuration with Mason
- Telescope fuzzy finder
- File tree with nvim-tree
- Auto-completion with nvim-cmp
- Custom keymaps and options

### Waybar
- Custom modules for system monitoring
- Styled to match the overall theme
- Workspace indicators and system tray

### Wofi
- Custom styling to match the desktop theme
- Optimized for quick application launching

## Usage

Once the symbolic links are created using `stow`, the respective applications will automatically pick up these configurations when you launch them.

### First Time Setup
After stowing the configurations:

1. **Restart your Hyprland session** or reload the configuration:
   ```bash
   hyprctl reload
   ```

2. **For Neovim**, the plugins will be automatically installed on first launch thanks to Lazy.nvim

3. **Restart Waybar** if it's already running:
   ```bash
   killall waybar && waybar &
   ```

## Customization

Feel free to modify these configurations to suit your preferences. The configurations are organized in a modular way:

- Hyprland configs are split into separate files for easy management
- Neovim plugins are organized by functionality
- Styling is separated from functionality where possible

## Troubleshooting

If you encounter issues:

1. **Check if stow created the links correctly:**
   ```bash
   ls -la ~/.config/hypr/
   ls -la ~/.config/nvim/
   ```

2. **For Hyprland issues**, check the logs:
   ```bash
   journalctl -f --user-unit hyprland
   ```

3. **For Neovim plugin issues**, run health checks:
   ```
   :checkhealth
   ```

## Screenshots

Check out the `hyprland/images/` directory for screenshots of the desktop setup in action!

## Contributing

If you have suggestions for improvements or find any issues, feel free to open an issue or submit a pull request.

## License

This repository is available under the MIT License. Feel free to use and modify these configurations for your own setup.
