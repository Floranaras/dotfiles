# Troubleshooting Guide

Solutions for common issues and problems you might encounter with the dotfiles setup.

## General Troubleshooting

### Check Installation
First, verify that all symbolic links are created correctly:

```bash
# Check symbolic links
ls -la ~/.config/{hypr,nvim,waybar,wofi,ghostty} ~/.tmux.conf ~/.zshrc

# Verify they point to your dotfiles directory
readlink ~/.config/hypr
readlink ~/.zshrc
```

### Verify Dependencies
Make sure all required dependencies are installed:

```bash
# Check core tools
stow --version
eza --version
glow --version
nvim --version
tmux -V

# Check fonts
fc-list | grep -i jetbrains
```

---

## Shell & Terminal Issues

### Zsh Configuration Problems

**Shell aliases not working:**
```bash
# Check if eza is installed and in PATH
which eza
eza --version

# Test aliases manually
alias | grep eza
alias | grep grun

# Reload shell configuration
source ~/.zshrc

# Check for syntax errors in .zshrc
zsh -n ~/.zshrc
```

**Oh My Zsh not loading:**
```bash
# Check Oh My Zsh installation
ls -la ~/.oh-my-zsh

# Reinstall if missing
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check for conflicting shell configurations
ls -la ~/.bash* ~/.profile ~/.zprofile
```

**Icons not displaying in eza:**
```bash
# Install Nerd Fonts
# Arch Linux:
sudo pacman -S ttf-jetbrains-mono-nerd

# Ubuntu/Debian:
sudo apt install fonts-nerd-font-jetbrainsmono

# macOS:
brew install font-jetbrains-mono-nerd-font

# Verify font installation
fc-list | grep -i "jetbrains mono nerd"
```

### Ghostty Terminal Issues

**Ghostty not starting:**
```bash
# Check if Ghostty is installed
which ghostty
ghostty --version

# Check configuration file
ls -la ~/.config/ghostty/config

# Test with default config
ghostty --config-file=/dev/null
```

**Font rendering issues:**
```bash
# Verify Nerd Font is installed
fc-list | grep -i jetbrains

# Update font cache
fc-cache -fv

# Check Ghostty font configuration
grep -i font ~/.config/ghostty/config
```

---

## Hyprland Issues

### Hyprland Won't Start

**Check Hyprland installation:**
```bash
# Verify Hyprland is installed
which Hyprland
Hyprland --version

# Check if running on Wayland-compatible hardware
ls /dev/dri/
```

**Configuration errors:**
```bash
# Check Hyprland configuration syntax
Hyprland -c ~/.config/hypr/hyprland.conf --test

# View Hyprland logs
journalctl -f --user-unit hyprland

# Start Hyprland with debugging
Hyprland -d
```

**Graphics issues:**
```bash
# Check graphics drivers
lspci | grep VGA
glxinfo | grep "OpenGL version"

# For NVIDIA users, ensure proper drivers
nvidia-smi

# Check environment variables
env | grep -E "(WAYLAND|XDG|WLR)"
```

### Window Management Problems

**Windows not tiling properly:**
```bash
# Check window rules
grep -A 5 -B 5 "windowrule" ~/.config/hypr/hyprland.conf

# Restart Hyprland
hyprctl reload

# Check active window properties
hyprctl activewindow
```

**Keybindings not working:**
```bash
# List all keybindings
hyprctl binds

# Check specific binding
grep -i "SUPER" ~/.config/hypr/hyprland.conf

# Test keybinding manually
hyprctl dispatch exec firefox
```

---

## Waybar Issues

### Waybar Not Appearing

**Check Waybar status:**
```bash
# Check if Waybar is running
pgrep waybar
ps aux | grep waybar

# Start Waybar manually
waybar

# Check configuration
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```

**Configuration errors:**
```bash
# Validate JSON configuration
json_pp < ~/.config/waybar/config

# Check CSS syntax
# Use any CSS validator or browser developer tools

# View Waybar logs
journalctl -f | grep waybar
```

**Missing icons:**
```bash
# Install Nerd Font symbols
sudo pacman -S ttf-nerd-fonts-symbols-mono  # Arch
sudo apt install fonts-nerd-font-*  # Ubuntu

# Check font configuration in style.css
grep -i font ~/.config/waybar/style.css

# Test with minimal config
waybar -c /dev/null
```

### Module Issues

**Audio module not working:**
```bash
# Check PulseAudio/PipeWire
pulseaudio --check
pactl info

# For PipeWire users
systemctl --user status pipewire
```

**Network module issues:**
```bash
# Check network interfaces
ip link show
nmcli device status

# Check NetworkManager
systemctl status NetworkManager
```

**Battery module problems:**
```bash
# Check battery information
ls /sys/class/power_supply/
cat /sys/class/power_supply/BAT*/capacity
acpi -b
```

---

## Neovim Issues

### Plugin Problems

**Plugins not loading:**
```bash
# Check Neovim version
nvim --version

# Open Neovim and check plugins
nvim -c ":Lazy"

# Sync plugins
nvim -c ":Lazy sync"

# Check health
nvim -c ":checkhealth"
```

**LSP not working:**
```bash
# Check LSP status in Neovim
nvim -c ":LspInfo"

# Check Mason installations
nvim -c ":Mason"

# Install missing servers
nvim -c ":MasonInstall clangd lua-language-server"

# Health check for LSP
nvim -c ":checkhealth lsp"
```

**Completion issues:**
```bash
# Check completion health
nvim -c ":checkhealth nvim-cmp"

# Restart LSP
nvim -c ":LspRestart"

# Check Node.js for some LSP servers
node --version
npm --version
```

### Markdown Preview Issues

**Peek Plugin Issues:**

**Preview window not opening (keybinding works but nothing happens):**

This is usually caused by missing webview dependencies. Peek requires a webview application to display the markdown preview.

```bash
# Install webkit2gtk (most common solution)
sudo pacman -S webkit2gtk  # Arch Linux
sudo apt install webkit2gtk-4.0-dev  # Ubuntu/Debian
brew install webkit2gtk  # macOS

# Alternative: Install a browser if webview doesn't work
sudo pacman -S firefox chromium brave-bin  # Choose one
```

**Configure app preference in Peek setup:**
```lua
require("peek").setup({
    app = 'webview',    -- Default, uses webkit2gtk
    -- app = 'browser',    -- Uses system default browser
    -- app = 'firefox',    -- Use specific browser
    -- app = 'brave',      -- For Brave browser users
    -- app = 'chromium',   -- For Chromium users
})
```

**Keybinding `<Space>md` not working:**

1. **Leader key not set or set too late:**
   ```lua
   -- Add this to the TOP of ~/.config/nvim/lua/callo/init.lua
   vim.g.mapleader = " "
   ```

2. **Plugin lazy loading preventing keymap creation:**
   ```lua
   -- Change from event = { "VeryLazy" } to:
   lazy = false,  -- Force immediate loading
   ```

3. **Test if plugin loads:**
   ```vim
   :lua require("peek").open()
   ```

**Complete working Peek configuration:**
```lua
{
  "toppair/peek.nvim",
  lazy = false,
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      auto_load = true,
      close_on_bdelete = true,
      syntax = true,
      theme = 'dark',
      update_on_change = true,
      app = 'webview',
      filetype = { 'markdown' },
    })
    
    vim.keymap.set("n", "<leader>md", function() require("peek").open() end, { desc = "Peek (Markdown Preview)" })
    vim.keymap.set("n", "<leader>mc", function() require("peek").close() end, { desc = "Peek Close" })
  end,
}
```

**Error symptoms:**
- `error: Module not found "file:///home/user/.local/share/nvim/lazy/peek.nvim/public/main.bundle.js"`
- `zsh:1: command not found: deno`

**Complete fix:**

1. **Install Deno (if not installed):**
   ```bash
   curl -fsSL https://deno.land/x/install/install.sh | sh
   ```

2. **Add Deno to PATH:**
   ```bash
   export PATH="$HOME/.deno/bin:$PATH"
   # Add to your ~/.zshrc to make it permanent
   echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

3. **Navigate to the Peek plugin directory:**
   ```bash
   cd ~/.local/share/nvim/lazy/peek.nvim
   ```

4. **Build the plugin:**
   ```bash
   deno task build:fast
   # or alternatively:
   deno task build
   ```

5. **Verify the build was successful:**
   ```bash
   ls -la public/
   # You should see main.bundle.js (around 3MB in size)
   ```

6. **Restart Neovim and test:**
   ```bash
   nvim test.md
   # Then in Neovim:
   :PeekOpen
   ```

**7. Install webkit2gtk for webview support:**
   ```bash
   # Required for Peek to display preview window
   sudo pacman -S webkit2gtk  # Arch Linux
   sudo apt install webkit2gtk-4.0-dev  # Ubuntu/Debian
   brew install webkit2gtk  # macOS
   ```

**8. Configure Peek plugin in your Neovim config:**
```lua
{
  "toppair/peek.nvim",
  lazy = false,  -- Load immediately to avoid keymap issues
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      auto_load = true,
      close_on_bdelete = true,
      syntax = true,
      theme = 'dark',
      update_on_change = true,
      app = 'webview',  -- or 'browser', 'firefox', 'chromium', 'brave'
      filetype = { 'markdown' },
    })
    
    -- Create keymaps manually for reliable loading
    vim.keymap.set("n", "<leader>md", function() require("peek").open() end, { desc = "Peek (Markdown Preview)" })
    vim.keymap.set("n", "<leader>mc", function() require("peek").close() end, { desc = "Peek Close" })
  end,
}
```

**Alternative: Glow for Markdown Preview:**

If you prefer a simpler terminal-based markdown preview:

```bash
# Install glow
sudo pacman -S glow  # Arch
sudo apt install glow  # Ubuntu (may need to add repository)
brew install glow     # macOS

# Test glow directly
glow README.md

# Use in Neovim
nvim -c ":Glow"
```

**Markdown rendering problems:**
```bash
# Check file type detection
nvim README.md -c ":set filetype?"

# Verify markdown files are recognized
nvim -c ":echo &filetype" README.md
```

### Performance Issues

**Slow startup:**
```bash
# Profile startup time
nvim --startuptime startup.log
cat startup.log | sort -k2 -n

# Check lazy loading
nvim -c ":Lazy profile"

# Disable plugins temporarily
mv ~/.config/nvim/lua/plugins ~/.config/nvim/lua/plugins.bak
```

---

## Tmux Issues

### Tmux Configuration Problems

**Tmux not loading config:**
```bash
# Check tmux configuration
tmux show-options -g

# Test configuration syntax
tmux -f ~/.tmux.conf

# Source config manually
tmux source-file ~/.tmux.conf

# Check for tmux plugins
ls -la ~/.tmux/plugins/
```

**Status bar issues:**
```bash
# Check status bar configuration
tmux show-options -g status
tmux show-options -g status-left
tmux show-options -g status-right

# Refresh status bar
tmux refresh-client -S
```

### Session Management

**Sessions not persisting:**
```bash
# List current sessions
tmux list-sessions

# Check tmux server status
tmux info

# Kill and restart tmux server
tmux kill-server
tmux
```

---

## Wofi Issues

### Application Launcher Problems

**Wofi not starting:**
```bash
# Test wofi directly
wofi --show=drun

# Check configuration
wofi --conf ~/.config/wofi/config --style ~/.config/wofi/style.css

# View wofi help
wofi --help
```

**Applications not appearing:**
```bash
# Update desktop database
update-desktop-database ~/.local/share/applications

# Check desktop files
ls /usr/share/applications/
ls ~/.local/share/applications/

# Clear wofi cache
rm -rf ~/.cache/wofi/
```

**Styling issues:**
```bash
# Validate CSS
# Check for syntax errors in ~/.config/wofi/style.css

# Test without custom styling
wofi --style /dev/null

# Check GTK theme compatibility
echo $GTK_THEME
```

---

## System Integration Issues

### Font and Icon Problems

**Icons not displaying correctly:**
```bash
# Install complete Nerd Fonts collection
sudo pacman -S ttf-nerd-fonts-symbols  # Arch
brew install font-symbols-only-nerd-font  # macOS

# Update font cache
fc-cache -fv

# Check font configuration
fc-match "JetBrains Mono Nerd Font"
```

**Font rendering issues:**
```bash
# Check font configuration
cat ~/.config/fontconfig/fonts.conf

# Test font rendering
echo "Test string with icons:      "

# Check available fonts
fc-list : family | sort | uniq
```

### Display and Graphics Issues

**Multiple monitor problems:**
```bash
# Check monitor detection
hyprctl monitors

# List available outputs
wlr-randr

# Check Xorg fallback (if needed)
xrandr

# Reset monitor configuration
hyprctl dispatch dpms off
hyprctl dispatch dpms on
```

**Scaling and resolution:**
```bash
# Check current scaling
hyprctl getoption misc:scale

# Set scaling temporarily
hyprctl keyword misc:scale 1.5

# Check display resolution
wlr-randr | grep current
```

### Audio Issues

**Audio not working:**
```bash
# Check audio system
pulseaudio --check
pactl info

# For PipeWire users
systemctl --user status pipewire
systemctl --user status pipewire-pulse

# List audio devices
pactl list sinks short
pactl list sources short

# Test audio output
speaker-test -t wav -c 2
```

**Waybar audio module issues:**
```bash
# Check PulseAudio connection
pactl stat

# Test volume control
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Check Waybar audio configuration
grep -A 10 "pulseaudio" ~/.config/waybar/config
```

---

## Development Environment Issues

### Gradle Development Problems

**Gradle aliases not working:**
```bash
# Check if you're in a Gradle project
ls -la | grep gradlew
ls -la | grep build.gradle

# Test gradle directly
./gradlew --version
gradle --version

# Initialize new project to test
mkdir test-project && cd test-project
gradle init --type java-application
```

**Java development issues:**
```bash
# Check Java installation
java --version
javac --version

# Check JAVA_HOME
echo $JAVA_HOME

# Set JAVA_HOME if missing
export JAVA_HOME=/usr/lib/jvm/default-java  # Ubuntu
export JAVA_HOME=/usr/lib/jvm/default       # Arch
```

### Git Integration Problems

**Git not working in Neovim:**
```bash
# Check git installation
git --version

# Check git configuration
git config --list

# Initialize git in project if needed
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Check vim-fugitive in Neovim
nvim -c ":G"
```

### LSP and Language Server Issues

**C/C++ development problems:**
```bash
# Check clangd installation
clangd --version
which clangd

# Install clangd
# Arch: sudo pacman -S clang
# Ubuntu: sudo apt install clangd
# macOS: brew install llvm

# Generate compile_commands.json for project
bear -- make  # or
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
```

**Python development issues:**
```bash
# Check Python LSP
pip3 install python-lsp-server
# or
pip3 install pyright

# Check Python environment
python3 --version
pip3 --version

# Install in Neovim
nvim -c ":MasonInstall pyright"
```

---

## Performance Optimization

### System Performance Issues

**High CPU usage:**
```bash
# Check running processes
htop
ps aux | head -20

# Check specific applications
pgrep -a waybar
pgrep -a hyprland

# Monitor system resources
iostat 1
vmstat 1
```

**Memory issues:**
```bash
# Check memory usage
free -h
cat /proc/meminfo

# Check swap usage
swapon --show

# Clear caches if needed
sudo sync && sudo sysctl vm.drop_caches=3
```

**GPU performance:**
```bash
# Check GPU usage
nvidia-smi  # NVIDIA
radeontop   # AMD
intel_gpu_top  # Intel

# Check GPU acceleration
glxinfo | grep -i "direct rendering"
```

### Application-Specific Performance

**Neovim slow startup:**
```bash
# Profile plugins
nvim --startuptime startup.log
sort -k2 -n startup.log

# Disable non-essential plugins temporarily
# Check lazy loading configuration
nvim -c ":Lazy profile"
```

**Waybar high resource usage:**
```bash
# Check module update intervals
grep -i interval ~/.config/waybar/config

# Increase intervals for less critical modules
# Disable unused modules
```

**Terminal performance:**
```bash
# Check terminal scrollback
grep -i scrollback ~/.config/ghostty/config

# Reduce scrollback if needed
# Check for large outputs
history | tail -100
```

---

## Network and Connectivity Issues

### Network Module Problems

**Waybar network module not updating:**
```bash
# Check NetworkManager
systemctl status NetworkManager

# Check network interfaces
ip link show
nmcli device status

# Restart NetworkManager if needed
sudo systemctl restart NetworkManager
```

**Wi-Fi connection issues:**
```bash
# List available networks
nmcli device wifi list

# Connect to network
nmcli device wifi connect "SSID" password "password"

# Check connection status
nmcli connection show --active
```

---

## Backup and Recovery

### Configuration Backup

**Create backup before changes:**
```bash
# Backup all configs
mkdir -p ~/.config-backup/$(date +%Y-%m-%d)
cp -r ~/.config/{hypr,waybar,wofi,ghostty,nvim} ~/.config-backup/$(date +%Y-%m-%d)/
cp ~/.tmux.conf ~/.zshrc ~/.config-backup/$(date +%Y-%m-%d)/

# Or use git to track changes
cd ~/.dotfiles
git add -A && git commit -m "Backup before changes"
```

**Restore from backup:**
```bash
# Restore specific configuration
cp -r ~/.config-backup/2024-01-01/hypr ~/.config/

# Restore all configurations
cd ~/.dotfiles
git reset --hard HEAD~1  # Go back one commit
stow */  # Reapply dotfiles
```

### Recovery Procedures

**Complete system recovery:**
```bash
# Remove all current configs
rm -rf ~/.config/{hypr,waybar,wofi,ghostty,nvim}
rm ~/.tmux.conf ~/.zshrc

# Reinstall dotfiles
cd ~/.dotfiles
stow */

# Restart services
hyprctl reload
source ~/.zshrc
tmux kill-server
killall waybar && waybar &
```

**Partial recovery (single application):**
```bash
# Example: Fix only Neovim
rm -rf ~/.config/nvim
cd ~/.dotfiles
stow nvim

# Open Neovim to reinstall plugins
nvim -c ":Lazy sync"
```

---

## Getting Help

### Log Files and Debugging

**Collect system information:**
```bash
# System info
uname -a
lsb_release -a  # Ubuntu/Debian
cat /etc/os-release

# Hardware info
lscpu
lsmem
lspci
lsusb

# Graphics info
glxinfo | head -20
```

**Application logs:**
```bash
# Hyprland logs
journalctl -f --user-unit hyprland

# System logs
journalctl -f

# Waybar debugging
waybar -l debug

# Neovim logs
nvim -V9nvim.log
```

### Community Resources

**Where to get help:**

1. **GitHub Issues**: Open issue in the dotfiles repository
2. **Hyprland Community**: 
   - Discord: https://discord.gg/hQ9XvMUjjr
   - Reddit: r/hyprland
3. **Neovim Community**:
   - Reddit: r/neovim
   - Matrix: #neovim:matrix.org
4. **General Linux Support**:
   - Distribution-specific forums
   - StackOverflow for specific errors
   - Reddit communities (r/linux, r/archlinux, etc.)

**When asking for help, include:**
- Operating system and version
- Hardware information (CPU, GPU, RAM)
- Exact error messages or unexpected behavior
- Steps to reproduce the issue
- Relevant log files or command outputs
- What you've already tried

### Creating Bug Reports

**Information to include:**

1. **Environment details**:
   ```bash
   uname -a
   echo $XDG_CURRENT_DESKTOP
   echo $WAYLAND_DISPLAY
   ```

2. **Application versions**:
   ```bash
   Hyprland --version
   waybar --version
   nvim --version
   ```

3. **Configuration files**:
   - Include relevant config snippets
   - Note any custom modifications

4. **Reproduction steps**:
   - Clear, step-by-step instructions
   - Expected vs actual behavior
   - Screenshots or recordings if applicable

5. **Logs and error messages**:
   - Complete error messages
   - Relevant log excerpts
   - Command outputs

Remember: The more specific and detailed your problem description, the easier it will be for others to help you solve it!

---

## Quick Fixes Summary

**Most common issues and their solutions:**

| Issue | Quick Fix |
|-------|-----------|
| Aliases not working | `source ~/.zshrc` |
| Icons not showing | Install Nerd Fonts, run `fc-cache -fv` |
| Neovim plugins broken | `:Lazy sync` in Neovim |
| **Peek plugin "Module not found"** | **Install Deno: `deno task build:fast`, then install webkit2gtk: `sudo pacman -S webkit2gtk`** |
| **Peek preview not opening** | **Install webkit2gtk: `sudo pacman -S webkit2gtk`** |
| Waybar not appearing | `killall waybar && waybar &` |
| Hyprland not responding | `hyprctl reload` |
| LSP not working | `:LspRestart` in Neovim |
| Tmux config not loaded | `tmux source-file ~/.tmux.conf` |
| Glow/markdown preview broken | Install glow: `sudo pacman -S glow` |
| Terminal font issues | Install JetBrains Mono Nerd Font |
| Stow conflicts | `stow -D */ && stow */` |
