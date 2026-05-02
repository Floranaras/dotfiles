-- Silence checkhealth warnings for providers we don't use
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_ruby_provider    = 0

-- Indentation
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true
vim.opt.wrap        = false

-- UI
vim.opt.guicursor     = ""
vim.opt.nu            = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline    = true
vim.opt.scrolloff     = 8
vim.opt.signcolumn    = "yes"
vim.opt.colorcolumn   = "100"
vim.opt.isfname:append("@-@")

-- Search
vim.opt.hlsearch  = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- Undo / backup
vim.opt.swapfile = false
vim.opt.backup   = false
vim.opt.undofile = true
vim.opt.undodir  = vim.env.HOME .. "/.vim/undodir"

-- System
vim.opt.updatetime = 50
vim.opt.shell      = "/bin/bash"
vim.opt.clipboard  = "unnamedplus"
vim.opt.backspace  = "indent,eol,start"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = "󰠠 ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },
  update_in_insert = false,
  underline        = true,
  severity_sort    = true,
  float            = { border = "rounded", source = "always", header = "", prefix = "" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript", "typescript", "javascriptreact", "typescriptreact",
    "html", "css", "json", "jsx", "tsx", "lua", "svelte",
  },
  callback = function()
    vim.opt_local.tabstop     = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.expandtab   = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop    = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.expandtab  = false
    vim.opt_local.cindent    = true
    vim.opt_local.cinoptions = ":0,l1,t0,+4,(0,u0,w1"
    vim.opt_local.autoindent = true
  end,
})
