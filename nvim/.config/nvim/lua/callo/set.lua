vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.shell = "/bin/bash"

vim.g.mapleader = " "

-- Additional settings from your config
-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Enhanced cursor line
vim.opt.cursorline = true

-- Better search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better backspace behavior
vim.opt.backspace = "indent,eol,start"

-- Web development specific settings (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "html",
        "css",
        "json",
        "jsx",
        "tsx"
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- C/C++ specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = false  -- Use actual tabs for C/C++
        vim.opt_local.cindent = true
        vim.opt_local.cinoptions = ":0,l1,t0,+4,(0,u0,w1"
        vim.opt_local.autoindent = true
    end,
})


