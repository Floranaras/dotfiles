--- @file treesitter.lua
--- @brief Configuration for Treesitter parsing and syntax highlighting.
--- Treesitter provides faster, more accurate syntax highlighting and
--- indentation by building a concrete syntax tree of the source code.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  --- @brief Initializes the Treesitter engine and sets up language parsers.
  config = function()
    -- Reverted to 'nvim-treesitter' as per your original working config.
    require("nvim-treesitter").setup({
      -- List of parsers to maintain.
      -- Formatted vertically for cleaner git diffs.
      ensure_installed = {
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "lua",
        "rust",
        "jsdoc",
        "bash",
        "html",
        "css",
        "tsx",
        "json",
      },

      -- Install parsers asynchronously to avoid blocking the UI.
      sync_install = false,

      -- Automatically install missing parsers when entering a new filetype.
      auto_install = true,

      -- Enable intelligent indentation based on the syntax tree.
      indent = {
        enable = true,
      },

      -- Configuration for syntax highlighting.
      highlight = {
        enable = true,
        -- Enable legacy vim regex highlighting for specific formats
        -- where Treesitter might be incomplete.
        additional_vim_regex_highlighting = { "markdown" },
      },
    })

    -- Register the 'templ' language for .templ filetypes.
    -- This ensures the Treesitter parser is correctly mapped.
    vim.treesitter.language.register("templ", "templ")
  end,
}
