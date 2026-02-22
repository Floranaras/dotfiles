--- @file pairs.lua
--- @brief Configuration for automatic bracket pairing and HTML/XML tagging.
--- This module sets up nvim-autopairs with specific language exclusions 
--- and nvim-ts-autotag for Treesitter-based tag management.

return {
  -- ===========================================================================
  -- 1. NVIM-AUTOPAIRS
  -- ===========================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    --- @brief Initializes autopairs and integrates it with nvim-cmp.
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        -- Disable autopairs for languages where it might conflict 
        -- with language-specific server behaviors or preferences.
        disable_filetype = {
          "lua",
          "c",
          "cpp",
          "rust",
          "python",
          "java",
          "javascript",
          "typescript",
        },
        check_ts = true, -- Enable Treesitter integration
      })

      -- Integrate with nvim-cmp to add brackets after selecting a function.
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ===========================================================================
  -- 2. NVIM-TS-AUTOTAG
  -- ===========================================================================
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    --- @brief Configures Treesitter-based auto-closing and auto-renaming of tags.
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename paired tags
          enable_close_on_slash = false, -- Internal slash behavior
        },
        -- Target specific web-based filetypes for tag management.
        filetypes = {
          "html",
          "xml",
          "javascriptreact",
          "typescriptreact",
        },
      })
    end,
  },
}
