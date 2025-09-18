# Neovim Configuration Guide

Complete guide to the Neovim setup, features, keybindings, and customization.

## Overview

This Neovim configuration provides a modern, powerful development environment with:
- **Complete LSP setup** with automatic server installation
- **Cross-platform compatibility** (Linux, macOS, Windows)
- **Beautiful markdown preview** with Glow
- **Smart completion** and snippet support
- **Fuzzy finding** and file navigation
- **Git integration** and version control
- **Rose Pine theme** with transparency
- **Automatic plugin management** with lazy.nvim

---

## Key Features

###  Language Server Protocol (LSP)
- **Automatic installation** via Mason
- **Multi-language support**: C/C++, Lua, Java, and more
- **Smart completion** with context awareness
- **Error diagnostics** and real-time feedback
- **Code actions** and refactoring tools

###  Markdown Excellence
- **Terminal-based preview** with Glow
- **GitHub-style rendering** with syntax highlighting
- **Beautiful formatting** for headers, lists, and code blocks
- **Integrated workflow** - preview directly in Neovim

### Powerful Search & Navigation
- **Telescope fuzzy finder** for files and content
- **Harpoon** for quick file switching
- **Live grep** search across entire projects
- **Git status integration** with vim-fugitive

---

## Installation & Setup

### Prerequisites
Ensure these are installed (see [INSTALLATION.md](INSTALLATION.md) for details):
- Neovim ≥ 0.10
- Git
- Node.js & npm
- ripgrep
- unzip
- glow
- Python3
- clangd (for C/C++)
- Java JDK (optional, for Java development)

### Plugin Management
Uses **lazy.nvim** for fast, modern plugin management:
- **Lazy loading** for optimal startup time
- **Automatic installation** on first launch
- **Cross-platform paths** - works everywhere
- **Health checks** and dependency validation

---

## Keybindings Reference

### Leader Key
The leader key is set to **`<space>`** for easy access.

### File Navigation

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>pf` | Find Files | Open Telescope file finder |
| `<space>ps` | Project Search | Live grep search in project |
| `<C-p>` | Git Files | Find files tracked by git |

### Harpoon (Quick File Access)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>a` | Add File | Add current file to Harpoon |
| `<C-e>` | Toggle Menu | Show/hide Harpoon quick menu |
| `<C-h>` | File 1 | Navigate to 1st Harpoon file |
| `<C-t>` | File 2 | Navigate to 2nd Harpoon file |
| `<C-n>` | File 3 | Navigate to 3rd Harpoon file |
| `<C-s>` | File 4 | Navigate to 4th Harpoon file |

### Git Integration

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>gs` | Git Status | Open git status with vim-fugitive |

### LSP (Language Server Protocol)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `K` | Hover Info | Show documentation for symbol |
| `<space>vws` | Workspace Symbol | Search workspace symbols |
| `<space>vd` | View Diagnostics | Show line diagnostics |
| `<space>vca` | Code Actions | Show available code actions |
| `<space>vrr` | References | Show symbol references |
| `<space>vrn` | Rename | Rename symbol |
| `<C-h>` | Signature Help | Show function signature |

### Code Formatting & Quality

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>f` | Format | Format current buffer |
| `[d` | Previous Diagnostic | Go to previous diagnostic |
| `]d` | Next Diagnostic | Go to next diagnostic |

### Markdown Preview

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>md` | Markdown Preview | Preview with Glow (press `q` to exit) |
| `:Glow` | Manual Glow | Command to run Glow directly |

### Utility Features

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<space>u` | Undo Tree | Toggle undo tree visualization |
| `<space>pv` | Project View | Return to netrw file explorer |

### Window Management

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<C-k>` | Move Up | Navigate to window above |
| `<C-j>` | Move Down | Navigate to window below |
| `<C-h>` | Move Left | Navigate to window left |
| `<C-l>` | Move Right | Navigate to window right |

---

## Plugin Ecosystem

### Core Plugins

#### **lazy.nvim** - Plugin Manager
- Fast startup with lazy loading
- Automatic plugin installation
- Health checks and updates
- Modern Lua-based configuration

#### **telescope.nvim** - Fuzzy Finder
- File finding with preview
- Live grep search
- Git file integration
- Extensible with custom pickers

#### **harpoon** - File Navigation
- Quick file bookmarking
- Instant file switching
- Project-specific file lists
- Minimal overhead navigation

### Language Support

#### **nvim-lspconfig** - LSP Configuration
- Pre-configured language servers
- Automatic capabilities detection
- Error handling and diagnostics
- Cross-platform compatibility

#### **mason.nvim** - LSP Manager
- Automatic LSP server installation
- Version management
- Cross-platform support
- Easy server configuration

#### **nvim-cmp** - Completion Engine
- Intelligent autocompletion
- Multiple completion sources
- Snippet integration
- Customizable appearance

### Development Tools

#### **vim-fugitive** - Git Integration
- Git status and diff viewing
- Commit and branch management
- Merge conflict resolution
- Git blame and log

#### **undotree** - Undo History
- Visual undo tree navigation
- Persistent undo history
- Time-travel through changes
- Diff visualization

#### **nvim-autopairs** - Smart Pairs
- Automatic bracket/quote pairing
- Context-aware insertion
- Multi-line support
- Customizable rules

### Syntax & Appearance

#### **nvim-treesitter** - Syntax Highlighting
- Modern syntax highlighting
- Code folding support
- Incremental parsing
- Language-aware features

#### **rose-pine** - Color Theme
- Beautiful anime-inspired colors
- Transparent background support
- Consistent across all elements
- Easy customization

---

## Language-Specific Features

### C/C++ Development
- **clangd** language server
- Smart completion and navigation
- Real-time error checking
- Header file management
- Refactoring tools

### Java Development
- **jdtls** (Eclipse JDT) language server
- Maven/Gradle project support
- Automatic imports
- Code generation
- Debugging support

### Lua Development
- **lua_ls** (Lua Language Server)
- Neovim API completion
- Type checking
- Documentation generation
- Plugin development support

---

## Markdown Workflow

### Features
The markdown setup provides a complete writing and documentation experience:

- **Live preview** with Glow rendering
- **GitHub-style formatting** with proper typography
- **Syntax highlighting** for code blocks
- **Table rendering** with proper alignment
- **Link handling** and navigation
- **Image display** (in supported terminals)

### Usage Examples

**Basic preview:**
```vim
" Open any .md file
:edit README.md

" Preview with Glow
<space>md
" or
:Glow

" Press 'q' to return to editing
```

**Advanced workflow:**
1. Edit markdown in split window
2. Use `<space>md` to preview
3. Return to editing with `q`
4. Use `<space>f` to format if needed

### Supported Markdown Features
- Headers (H1-H6) with proper hierarchy
- **Bold** and *italic* text
- `inline code` and code blocks
- > Blockquotes
- Ordered and unordered lists
- Tables with alignment
- Links and references
- Horizontal rules
- Strikethrough text

---

## Customization

### Adding Language Servers

Edit your Neovim configuration to add new LSP servers:

```lua
-- In your LSP setup
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',      -- C/C++
        'lua_ls',      -- Lua
        'jdtls',       -- Java
        'pyright',     -- Python (add this)
        'tsserver',    -- TypeScript (add this)
    }
})
```

### Custom Keybindings

Add personal keybindings to your configuration:

```lua
-- Custom mappings
vim.keymap.set('n', '<leader>w', vim.cmd.w, { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', vim.cmd.q, { desc = 'Quit' })
vim.keymap.set('n', '<leader>x', vim.cmd.x, { desc = 'Save and quit' })
```

### Theme Customization

Modify the Rose Pine theme settings:

```lua
require('rose-pine').setup({
    disable_background = true,  -- Transparent background
    disable_float_background = true,
    styles = {
        italic = false,         -- Disable italics
        transparency = true,    -- Enable transparency
    }
})
```

### Plugin Configuration

Add new plugins to your lazy.nvim setup:

```lua
return {
    -- Your new plugin
    {
        'plugin-author/plugin-name',
        config = function()
            require('plugin-name').setup({
                -- Plugin configuration
            })
        end
    }
}
```

---

## Troubleshooting

### Common Issues

**Plugins not loading:**
```vim
" Check plugin status
:Lazy

" Sync plugins
:Lazy sync

" Check health
:checkhealth
```

**LSP not working:**
```vim
" Check LSP status
:LspInfo

" Check Mason installations
:Mason

" Health check for LSP
:checkhealth lsp
```

**Markdown preview not working:**
```bash
# Check if glow is installed
glow --version

# Install glow (see INSTALLATION.md)
# Test glow directly
glow README.md
```

**Completion not working:**
```vim
" Check completion sources
:checkhealth nvim-cmp

" Restart LSP
:LspRestart
```

### Performance Issues

**Slow startup:**
```vim
" Profile startup time
nvim --startuptime startup.log

" Check lazy loading
:Lazy profile
```

**High memory usage:**
- Check Treesitter parsers: `:TSInstallInfo`
- Disable unused language servers
- Review plugin configurations

### Debugging

**LSP debugging:**
```vim
" Enable LSP logging
:set verbose=1

" View LSP logs
:LspLog
```

**General debugging:**
```vim
" Check all health
:checkhealth

" View messages
:messages

" Check options
:set
```

---

## Advanced Features

### Custom Commands

The configuration includes several custom commands:

```vim
" Format current buffer
:Format

" Toggle diagnostics
:DiagnosticsToggle

" Reload configuration
:ReloadConfig
```

### Workflow Integration

**With Tmux:**
- Seamless navigation between Neovim and terminal
- Session persistence
- Copy/paste integration

**With Git:**
- Stage changes from within Neovim
- View diffs and conflicts
- Commit directly from editor

**With Shell:**
- Terminal integration for running commands
- File management with netrw
- External tool integration

### Project Management

**Per-project configuration:**
- `.nvim.lua` files for project-specific settings
- Local LSP configurations
- Custom keybindings per project

**Session management:**
- Automatic session saving
- Project-specific layouts
- Quick project switching

---

## Tips & Best Practices

### Efficient Workflow

1. **Use Harpoon** for frequently accessed files
2. **Master Telescope** for project navigation
3. **Leverage LSP features** for code intelligence
4. **Use git integration** for version control
5. **Preview markdown** regularly when writing docs

### Learning Path

1. Start with basic navigation (`<space>pf`, `<space>ps`)
2. Learn Harpoon for quick file access
3. Explore LSP features (`gd`, `K`, code actions)
4. Use git integration for version control
5. Customize keybindings and plugins

### Productivity Tips

- Use `<space>a` to bookmark important files
- Leverage `K` for quick documentation
- Use `<space>f` to format code consistently
- Preview markdown with `<space>md` while writing
- Use `<space>u` to visualize complex undo history

For more configuration details, see [CONFIGURATION.md](CONFIGURATION.md)
