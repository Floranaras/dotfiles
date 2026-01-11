# Neovim Configuration

## Overview

LSP-enabled setup with fuzzy finding, git integration, and database tools.

## Plugins

### Core
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Lua utility library

### LSP & Completion
- **nvim-lspconfig** - LSP client configurations
- **mason.nvim** - LSP/tool installer
- **mason-lspconfig.nvim** - Mason + lspconfig bridge
- **nvim-cmp** - Completion engine
- **cmp-nvim-lsp** - LSP source for nvim-cmp
- **cmp-buffer** - Buffer text completion
- **cmp-path** - File path completion
- **cmp-cmdline** - Command line completion
- **LuaSnip** - Snippet engine
- **nvim-jdtls** - Java LSP (custom ftplugin)

### Syntax & UI
- **nvim-treesitter** - Syntax highlighting
- **nvim-ts-autotag** - Auto-close HTML/JSX tags
- **nvim-autopairs** - Auto-close brackets (disabled for most languages)
- **rose-pine** - Color scheme (default)
- **tokyonight.nvim** - Alternative color scheme

### Navigation
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - Better sorting
- **harpoon** - Quick file navigation
- **undotree** - Undo history visualizer

### Git
- **vim-fugitive** - Git wrapper

### Development Tools
- **vim-dadbod** - Database interface
- **vim-dadbod-ui** - Database UI
- **vim-dadbod-completion** - SQL completion
- **live-server.nvim** - HTML live reload
- **emmet-vim** - HTML/CSS expansion
- **peek.nvim** - Markdown preview with mermaid support

### Utilities
- **plenary.nvim** - Javadoc generator (custom)

## Keybindings

Leader key: `<Space>`

### General Navigation
| Key | Action |
|-----|--------|
| `<leader>pv` | File explorer |
| `<leader>pr` | Project root explorer |
| `<leader>nf` | New file (relative) |
| `<leader>nF` | New file (from root) |
| `<C-d>` | Half page down (centered) |
| `<C-u>` | Half page up (centered) |
| `n` | Next search (centered) |
| `N` | Previous search (centered) |

### Telescope
| Key | Action |
|-----|--------|
| `<leader>pf` | Find files |
| `<C-p>` | Git files |
| `<leader>ps` | Live grep |
| `<leader>pws` | Grep word under cursor |
| `<leader>pWs` | Grep WORD under cursor |
| `<leader>pb` | Find buffers |
| `<leader>vh` | Help tags |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>vws` | Workspace symbol |
| `<leader>vd` | Show diagnostics |
| `[d` | Next diagnostic |
| `]d` | Previous diagnostic |
| `<leader>ca` | Code actions |
| `<leader>vrr` | References |
| `<leader>vrn` | Rename |
| `<leader>f` | Format |
| `<C-h>` | Signature help (insert mode) |

### Harpoon
| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<C-h>` | Navigate to mark 1 |
| `<C-n>` | Navigate to mark 2 |
| `<C-s>` | Navigate to mark 3 |
| `<C-t>` | Navigate to mark 4 |

### Git (Fugitive)
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>p` | Git push (in fugitive buffer) |
| `<leader>P` | Git pull --rebase (in fugitive buffer) |
| `<leader>t` | Git push -u origin (in fugitive buffer) |
| `gu` | Accept left (merge conflict) |
| `gh` | Accept right (merge conflict) |

### Mermaid
| Key | Action |
|-----|--------|
| `<leader>mm` | Open browser to preview mermaid/markdown files |


### Markdown
| Key | Action |
|-----|--------|
| `<leader>md` | Toggle markdown preview |

### Gradle
| Key | Action |
|-----|--------|
| `<leader>gr` | Gradle run |
| `<leader>gb` | Gradle build |
| `<leader>gt` | Gradle test |

### Utility
| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undotree |
| `<leader>nh` | Clear search highlights |
| `<leader>tt` | Terminal at project root |
| `<leader>zig` | Restart LSP |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `<leader>y` | Yank to system clipboard |
| `<leader>d` | Delete to void register |
| `<leader>s` | Search/replace word under cursor |

## Settings

### Editor
- Line numbers: relative
- Tab width: 1 space (expandtab)
- Smart indent: enabled
- Line wrap: disabled
- Swap file: disabled
- Undo file: enabled (~/.vim/undodir)
- Scroll offset: 8 lines
- Color column: 80

### C/C++ Specific
- Tab width: 1 space (actual tabs, not spaces)
- cindent: enabled
- Custom cinoptions for formatting

## Language Support

### Configured
- **C/C++**: clangd
- **Lua**: lua_ls (vim globals recognized)
- **Java**: jdtls (per-project workspaces)

### Via Treesitter
- JavaScript, TypeScript, HTML, CSS, JSON, Rust, Bash, JSDoc, TSX

## Color Scheme

**Default**: rose-pine
- Transparent background
- Dark variant
- No italics

**Alternative**: tokyonight (storm)
- Available via `:ColorScheme tokyonight`

## File-Specific Features

### Java
- Automatic Javadoc generation
- JDTLS with Maven/Gradle support
- Lombok support (if lombok.jar found)
- Per-project workspaces

### Markdown
- Live preview with mermaid diagram support
- Auto-save on change

### HTML/CSS/JS
- Live server with auto-reload
- Emmet expansion (Ctrl+y)
- Auto-save on change
- Auto-close tags

### SQL
- Database UI with connection management
- Auto-completion
- Query execution and saving
- Result viewing

## Commands

| Command | Description |
|---------|-------------|
| `:Mason` | Open LSP installer |
| `:Lazy` | Open plugin manager |
| `:ColorScheme [theme]` | Switch color scheme |
| `:JdtStart` | Start Java LSP |
| `:PeekRebuild` | Rebuild markdown previewer |
| `:LiveServerStart` | Start HTML live server |
| `:LiveServerStop` | Stop HTML live server |
| `:DBUI` | Open database UI |

## Notes

- Autopairs disabled for most languages (enabled only for lua initially)
- Telescope uses master branch (Neovim 0.11.5 compatibility)
- Treesitter highlighting disabled in Telescope previews
- Java LSP checks Mason first, falls back to system installation
- Database queries auto-save to ~/sql_queries
