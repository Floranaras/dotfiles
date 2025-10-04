# Web Development Setup Guide

A comprehensive guide to the web development tools and keybindings in this Neovim configuration.

## Table of Contents
- [Live Server](#live-server)
- [Emmet](#emmet)
- [Auto-close & Auto-tag](#auto-close--auto-tag)
- [LSP Features](#lsp-features)
- [File Auto-save](#file-auto-save)

---

## Live Server

Real-time browser preview with automatic reloading.

### Keybindings
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ls` | Start Live Server | Opens browser at `http://localhost:8080` |
| `<leader>lc` | Stop Live Server | Closes the live server |

### How it works
1. Open any HTML file in Neovim
2. Press `<Space>ls` to start the server
3. Your default browser opens automatically
4. Changes auto-save and reload in real-time as you type
5. Press `<Space>lc` to stop when done

---

## Emmet

Lightning-fast HTML/CSS writing using abbreviations.

### Trigger Key
Press `Ctrl+y` then `,` (comma) to expand abbreviations

### Common Patterns

#### Basic Elements
```
div          →  <div></div>
p            →  <p></p>
span         →  <span></span>
```

#### Classes and IDs
```
div.container       →  <div class="container"></div>
p#intro            →  <p id="intro"></p>
button.btn.primary →  <button class="btn primary"></button>
```

#### Nesting (use `>`)
```
div>p              →  <div><p></p></div>
nav>ul>li          →  <nav><ul><li></li></ul></nav>
```

#### Siblings (use `+`)
```
h1+p               →  <h1></h1><p></p>
div+div+div        →  <div></div><div></div><div></div>
```

#### Multiplication (use `*`)
```
li*3               →  <li></li><li></li><li></li>
div.item*4         →  <div class="item"></div> (x4)
```

#### Combinations
```
ul>li.item*3       →  <ul>
                        <li class="item"></li>
                        <li class="item"></li>
                        <li class="item"></li>
                      </ul>

nav>ul>li*5>a      →  Full navigation structure
```

#### HTML5 Boilerplate
```
!                  →  Complete HTML5 template with head, body, etc.
```

### Usage Example
1. Type: `div.hero>h1.title+p.subtitle`
2. Press: `Ctrl+y,`
3. Get:
```html
<div class="hero">
    <h1 class="title"></h1>
    <p class="subtitle"></p>
</div>
```

---

## Auto-close & Auto-tag

Automatic HTML tag completion and synchronization.

### Auto-close Tags
- Type `<div` then `>`
- Automatically adds `</div>`
- Works for all HTML tags

### Auto-rename Tags
- Change opening tag `<div>` to `<section>`
- Closing tag `</div>` automatically updates to `</section>`
- Works in both directions

### Supported Files
- `.html`
- `.xml`
- `.jsx` (React)
- `.tsx` (TypeScript React)

### Note on Autopairs
Autopairs (auto-closing brackets, quotes) is **DISABLED** for programming languages (JavaScript, TypeScript, Lua, C/C++, etc.) but **ENABLED** for HTML/XML files only.

---

## LSP Features

Language Server Protocol support for HTML, CSS, JavaScript/TypeScript.

### Keybindings
| Key | Action | Description |
|-----|--------|-------------|
| `K` | Hover Documentation | Show info about element/function under cursor |
| `gd` | Go to Definition | Jump to where something is defined |
| `<leader>vd` | Open Diagnostic Float | Show error/warning details |
| `[d` | Next Diagnostic | Jump to next error/warning |
| `]d` | Previous Diagnostic | Jump to previous error/warning |
| `<leader>vca` | Code Action | Show available fixes/refactors |
| `<leader>vrr` | Show References | Find all references to symbol |
| `<leader>vrn` | Rename Symbol | Rename variable/function everywhere |
| `<leader>f` | Format Document | Auto-format current file |
| `Ctrl+h` (Insert) | Signature Help | Show function signature while typing |

### Installed Language Servers
- **HTML** - HTML tag completion and validation
- **CSS** - CSS property completion and validation
- **TypeScript/JavaScript** - Full JS/TS support
- **Emmet LSP** - Emmet completions in LSP

### Auto-completion
- Trigger with `Ctrl+Space` or automatic while typing
- `Ctrl+n` / `Ctrl+p` to navigate suggestions
- `Ctrl+y` or `Enter` to accept
- Works for HTML tags, CSS properties, JavaScript, etc.

---

## File Auto-save

Automatic saving for seamless live preview.

### Auto-save Triggers
Files are automatically saved when:
1. **Text changes** in INSERT mode (`TextChangedI`)
2. **Text changes** in NORMAL mode (`TextChanged`)
3. **Leaving INSERT mode** (`InsertLeave`)

### Affected Files
- `*.html`
- `*.css`
- `*.js`

### Why?
This enables real-time browser updates without manually saving. Your changes appear in the browser as you type!

---

## Quick Start Workflow

### 1. Start a New Project
```bash
mkdir my-project
cd my-project
nvim index.html
```

### 2. Create HTML Structure
- Type `!` then `Ctrl+y,` for HTML5 template
- Add content with Emmet shortcuts
- Example: `div.container>h1+p` then `Ctrl+y,`

### 3. Start Live Server
- Press `<Space>ls`
- Browser opens automatically

### 4. Edit and See Changes
- Make changes in HTML/CSS/JS
- Changes auto-save and reload in browser
- No manual refresh needed!

### 5. Stop Server
- Press `<Space>lc` when done

---

## Tips & Tricks

### Emmet Pro Tips
- Learn the basic patterns: `>` (child), `+` (sibling), `*` (multiply)
- Use `!` for quick HTML5 boilerplate
- Combine classes: `div.container.flex.center`
- Add attributes: `a[href="#"]` → `<a href="#"></a>`

### LSP Pro Tips
- Use `K` frequently to learn about HTML elements
- Press `gd` on a class name to jump to CSS definition
- Use `<leader>vrr` to find where CSS classes are used
- Format with `<leader>f` before committing code

### Live Server Tips
- Start server ONCE, it handles all HTML/CSS/JS files in the directory
- Keep browser window visible while coding
- Multiple HTML files? Just open them at `localhost:8080/filename.html`

---

## Troubleshooting

### Emmet not working?
- Make sure you're in a `.html`, `.css`, or `.jsx` file
- Remember: `Ctrl+y` then `,` (two separate keypresses)
- Check if `Ctrl+y` conflicts with other mappings

### Live Server not updating?
- Check if auto-save is working (file should save automatically)
- Restart the server: `<leader>lc` then `<leader>ls`
- Make sure you're editing HTML/CSS/JS files

### LSP not showing completions?
- Run `:Mason` to check if servers are installed
- Look for: `html`, `cssls`, `ts_ls`, `emmet_ls`
- Restart LSP: `<leader>zig`

### Auto-close tags not working?
- Only works in `.html`, `.jsx`, `.tsx` files
- Make sure nvim-treesitter is installed
- Check `:TSInstall html` is successful

---

## Required Dependencies

### System Requirements
- **Node.js & npm** - For live-server and language servers
- **live-server** - Install: `npm install -g live-server`

### Neovim Plugins (auto-installed via Lazy)
- `mattn/emmet-vim` - Emmet support
- `barrett-ruth/live-server.nvim` - Live server integration
- `windwp/nvim-autopairs` - Auto-close pairs (HTML only)
- `windwp/nvim-ts-autotag` - Auto-close/rename HTML tags
- `neovim/nvim-lspconfig` - LSP configuration
- `williamboman/mason.nvim` - LSP installer
- `nvim-treesitter` - Better syntax highlighting

### Mason LSP Servers (auto-installed)
- `html` - HTML language server
- `cssls` - CSS language server
- `ts_ls` - TypeScript/JavaScript language server
- `emmet_ls` - Emmet language server

---

## File Structure Reference

```
~/.config/nvim/lua/plugins/
├── emmet.lua          # Emmet configuration
├── autopairs.lua      # Auto-pairs and auto-tag
├── liveserver.lua     # Live server setup
├── lsp.lua            # LSP configuration (update this)
└── treesitter.lua     # Treesitter (update this)
```

---

