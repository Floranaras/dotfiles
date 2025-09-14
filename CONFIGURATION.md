# Configuration Guide

Detailed explanation of all configuration files and how they work together to create the anime-inspired rice.

## Overview

This dotfiles setup creates a cohesive, beautiful desktop environment where each component is carefully themed and optimized to work together. The configurations are designed around a **serene anime night sky aesthetic** with deep blues, purples, and gentle pinks.

---

## Configuration Architecture

### File Structure
```
~/.dotfiles/
├── ghostty/          # Terminal emulator config
│   └── config        # Ghostty configuration
├── hypr/             # Hyprland window manager
│   ├── hyprland.conf  # Main Hyprland config
│   └── hyprpaper.conf # Wallpaper configuration
├── nvim/             # Neovim editor setup
│   ├── init.lua       # Main Neovim config
│   ├── lua/           # Lua configuration modules
│   └── after/         # After-load configurations
├── tmux/             # Terminal multiplexer
│   └── .tmux.conf     # Tmux configuration
├── waybar/           # Status bar
│   ├── config         # Waybar configuration
│   └── style.css      # Waybar styling
├── wofi/             # Application launcher
│   ├── config         # Wofi configuration
│   └── style.css      # Wofi styling
└── zsh/              # Shell configuration
    └── .zshrc         # Zsh configuration and aliases
```

---

## Hyprland Configuration

### Window Management Philosophy
The Hyprland setup focuses on **dynamic tiling** with **smooth animations** and **intuitive keybindings**.

#### Key Features:
- **Smooth animations** for window transitions
- **Smart gaps** that adjust based on window count  
- **Multi-monitor support** with proper workspace distribution
- **Custom window rules** for specific applications
- **Optimized for productivity** while maintaining beauty

#### Animation System:
```conf
animations {
    enabled = yes
    bezier = anime, 0.25, 0.1, 0.25, 1.0
    
    animation = windows, 1, 7, anime
    animation = windowsOut, 1, 7, anime, popin 80%
    animation = border, 1, 10, anime
    animation = borderangle, 1, 8, anime
    animation = fade, 1, 7, anime
    animation = workspaces, 1, 6, anime
}
```

#### Workspace Layout:
- **Workspaces 1-5**: Primary monitor activities
- **Workspaces 6-10**: Secondary monitor (if available)
- **Dynamic workspace switching** with smooth transitions
- **Per-workspace window rules** for consistent layouts

### Input & Interaction
- **Natural scrolling** and **tap-to-click**
- **Optimized mouse acceleration** for precision
- **Custom keybindings** following vim-like philosophy
- **Screenshot integration** with selection and clipboard

---

## Waybar Configuration  

### Design Philosophy
The Waybar creates a **minimal, informative status bar** that complements the anime aesthetic without being distracting.

#### Modules & Layout:
```json
{
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery", "tray"]
}
```

#### Anime-Inspired Styling:
- **Deep blue background** (`#1a1b26`) with transparency
- **Gentle purple accents** for active elements
- **Soft pink highlights** for important notifications
- **Nerd Font icons** for visual consistency
- **Smooth hover transitions** matching Hyprland animations

#### Smart Features:
- **Workspace indicators** show window count and activity
- **Audio control** with scroll wheel volume adjustment
- **Network status** with connection quality indicators
- **Battery management** with charging animations
- **System tray** integration for background applications

---

## Ghostty Terminal

### Terminal Philosophy
Ghostty provides a **modern, fast terminal** that serves as the foundation for the development workflow.

#### Key Features:
- **GPU acceleration** for smooth rendering
- **True color support** for proper theme display
- **Font configuration** optimized for code and icons
- **Transparency support** that integrates with the desktop
- **Performance optimized** for large outputs and scrolling

#### Theme Integration:
- **Rose Pine color palette** matching Neovim
- **Transparent background** showing desktop wallpaper
- **Consistent typography** with the system theme
- **Icon support** for file listings and git status

---

## Tmux Configuration

### Session Management Philosophy  
Tmux extends the terminal experience with **persistent sessions** and **beautiful status styling**.

#### Anime-Themed Design:
- **Status bar colors** matching Waybar and overall theme
- **Window indicators** using consistent color palette
- **Pane borders** with subtle anime-inspired colors
- **Session info** displayed with elegant typography

#### Productivity Features:
- **Smart pane navigation** with vim-like keybindings  
- **Session persistence** across reboots
- **Copy-paste integration** with system clipboard
- **Window management** optimized for development workflow

#### Status Bar Elements:
- **Session name** with distinctive styling
- **Window list** with activity indicators  
- **Current pane information** 
- **System integration** showing time and status

---

## Wofi Application Launcher

### Design Concept
Wofi provides a **clean, searchable application launcher** that appears on demand and disappears seamlessly.

#### Visual Design:
- **Rounded corners** matching the overall aesthetic
- **Transparent background** with blur effects
- **Anime color palette** for consistency
- **Smooth animations** for show/hide transitions
- **Typography** consistent with system theme

#### Functionality:
- **Fuzzy search** for quick application finding
- **Recent applications** prioritization
- **Custom styling** per application category
- **Keyboard navigation** optimized for speed
- **Integration** with Hyprland workspace management

---

## Neovim Integration

### Editor as IDE Philosophy
Neovim serves as the **central development environment**, deeply integrated with the overall workflow.

#### Theme Consistency:
- **Rose Pine theme** matching terminal and desktop
- **Transparent background** showing desktop through terminal
- **Consistent typography** with system fonts
- **Icon integration** using Nerd Fonts throughout

#### Workflow Integration:
- **Terminal integration** for running commands
- **Git workflow** integrated with overall VCS approach
- **File management** consistent with shell aliases
- **Project navigation** optimized for development

---

## Shell Environment (Zsh)

### Shell Philosophy
Zsh provides the **command-line interface** that ties everything together with modern conveniences and beautiful output.

#### Integration Points:
- **Eza file listings** with icons matching desktop theme
- **Git integration** showing status in prompt and listings  
- **Development tools** easily accessible through aliases
- **Environment management** for various programming languages

#### Visual Consistency:
- **Oh My Zsh theme** chosen to complement overall aesthetic
- **Color output** from eza matching desktop palette
- **Icon usage** consistent with Waybar and application themes
- **Typography** using the same fonts as terminal and editor

---

## Theme Coordination

### Color Palette System
All configurations use variations of the core anime-inspired palette:

#### Primary Colors:
- **Deep Blue**: `#1a1b26` - Main backgrounds
- **Rich Purple**: `#7c3aed` - Accents and highlights  
- **Soft Pink**: `#f472b6` - Important elements and notifications
- **Gentle Lavender**: `#a78bfa` - Secondary accents

#### Usage Across Components:
- **Hyprland**: Window borders and active indicators
- **Waybar**: Background, text, and module highlights
- **Wofi**: Background, selection, and text colors
- **Tmux**: Status bar, pane borders, and indicators
- **Neovim**: Editor theme with Rose Pine variation
- **Terminal**: Background, text, and accent colors

### Typography System
Consistent font usage across all applications:

#### Primary Font:
- **JetBrains Mono Nerd Font** for terminals and code
- **Consistent sizing** across applications
- **Icon integration** using Nerd Font symbols
- **Fallback fonts** for system consistency

---

## Integration Features

### Inter-Application Communication

#### File Management Workflow:
1. **Shell (eza)** → Beautiful file listings with icons
2. **Neovim** → File editing with LSP and completion
3. **Tmux** → Session management and terminal multiplexing  
4. **Git integration** → Version control across all components

#### Development Workflow:
1. **Hyprland** → Window management for development layout
2. **Ghostty** → Terminal for running commands
3. **Neovim** → Code editing with full IDE features
4. **Waybar** → System monitoring and status updates

#### Application Launching:
1. **Wofi** → Application discovery and launching
2. **Hyprland** → Window placement and workspace management
3. **Waybar** → Active application indication
4. **System integration** → Proper focus and workspace switching

### Data Sharing
- **Clipboard integration** across all applications
- **Environment variables** shared between shell and applications
- **Configuration consistency** through shared color and font definitions
- **Session persistence** maintaining state across restarts

---

## Customization Guide

### Adding New Applications

#### To maintain theme consistency:

1. **Colors**: Use the established palette
2. **Fonts**: Use JetBrains Mono Nerd Font family
3. **Transparency**: Match existing transparency levels
4. **Animations**: Use similar timing and curves as Hyprland

#### Configuration template:
```conf
# Application config template
background-color = #1a1b26
text-color = #c0caf5
accent-color = #7c3aed
highlight-color = #f472b6
font = JetBrains Mono Nerd Font
transparency = 0.85
```

### Theme Modifications

#### To adjust the color scheme:

1. **Update base colors** in each configuration file
2. **Maintain contrast ratios** for accessibility  
3. **Test across all applications** for consistency
4. **Update wallpaper** to match new palette

#### Color modification checklist:
- [ ] Hyprland window borders and gaps
- [ ] Waybar background and module colors
- [ ] Wofi styling and selection colors
- [ ] Tmux status bar and pane borders
- [ ] Terminal color scheme
- [ ] Neovim theme selection

### Performance Tuning

#### For optimal performance:

1. **Animation settings** can be reduced for older hardware
2. **Transparency levels** can be lowered to reduce GPU load
3. **Plugin counts** in Neovim can be optimized
4. **Waybar modules** can be disabled if not needed

---

## Maintenance

### Regular Updates
- **Check for application updates** monthly
- **Update plugin dependencies** in Neovim
- **Review configuration changes** in major updates
- **Backup configurations** before major changes

### Configuration Backup
```bash
# Backup current configs
cp -r ~/.config/hypr ~/.config/hypr.backup
cp -r ~/.config/waybar ~/.config/waybar.backup
# etc.

# Or use git to track changes
cd ~/.dotfiles
git add -A && git commit -m "Update configurations"
```

### Troubleshooting Configuration Issues
1. **Check individual application logs**
2. **Test configurations in isolation**
3. **Verify file permissions and paths**
4. **Use application-specific debugging tools**

For specific troubleshooting steps, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).
