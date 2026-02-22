--- @file spell.lua
--- @brief Integrated spell checking and completion configuration.
--- This module enables native Neovim spell checking for prose-heavy files
--- and integrates suggestions directly into the nvim-cmp completion menu.

return {
  -- ===========================================================================
  -- 1. CMP-SPELL (Completion Source)
  -- ===========================================================================
  {
    "f3fora/cmp-spell",
    dependencies = { "hrsh7th/nvim-cmp" },
  },

  -- ===========================================================================
  -- 2. NATIVE SPELL CONFIGURATION
  -- ===========================================================================
  {
    "spell-config",
    dir = vim.fn.stdpath("config"),
    --- @brief Configures autocommands for prose-based filetypes.
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typst", "markdown", "text", "tex" },
        callback = function()
          -- Enable native spell checking for the current buffer.
          -- Use window-local (wo) for direct boolean access.
          vim.wo.spell = true
          vim.opt_local.spelllang = "en_us"

          -- Add 'spell' source to nvim-cmp for the current buffer only.
          local cmp = require("cmp")
          cmp.setup.buffer({
            sources = cmp.config.sources({
              {
                name = "spell",
                option = {
                  keep_all_entries = false,
                  enable_in_context = function() return true end,
                },
              },
              { name = "buffer" },
              { name = "path" },
            }),
          })

          -- Keybinding options
          local opts = { buffer = true, silent = true }

          -- Toggle spell check with status message.
          -- Uses vim.wo to avoid 'get' field warnings.
          vim.keymap.set("n", "<leader>ss", function()
            vim.wo.spell = not vim.wo.spell
            local status = vim.wo.spell and "ON" or "OFF"
            print("Spell check: " .. status)
          end, { buffer = true, desc = "Toggle spell check" })

          -- Standard spell interaction bindings.
          vim.keymap.set("n", "<leader>sa", "zg", opts) -- Add word
          vim.keymap.set("n", "<leader>sc", "z=", opts) -- Show suggestions
          vim.keymap.set("n", "]s", "]s", opts)         -- Next error
          vim.keymap.set("n", "[s", "[s", opts)         -- Prev error
        end,
      })

      -- =======================================================================
      -- 3. UI & HIGHLIGHTING
      -- =======================================================================

      -- Custom colors for spell errors (Catppuccin-style palette).
      vim.api.nvim_set_hl(0, "SpellBad", {
        undercurl = true,
        sp = "#f38ba8",
      })
      vim.api.nvim_set_hl(0, "SpellCap", {
        undercurl = true,
        sp = "#fab387",
      })
    end,
  },
}
