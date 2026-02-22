--- @file typst.lua
--- @brief Real-time previewer for Typst documents.
--- This module manages the Typst previewer binary, sets up localized 
--- keybindings, and implements auto-save functionality for live updates.

return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    --- @brief Updates the previewer binary on plugin build/update.
    build = function()
      require("typst-preview").update()
    end,

    --- @type table Configuration options for the previewer.
    opts = {
      debug = false,

      -- Specify binary paths if not in system PATH; nil uses defaults.
      dependencies_bin = {
        ["typst-preview"] = nil,
        ["websocat"] = nil,
      },

      --- Determine the root directory of the project.
      --- @param path_of_main_file string Path to the main entry file.
      --- @return string The parent directory path.
      get_root = function(path_of_main_file)
        return vim.fn.fnamemodify(path_of_main_file, ":p:h")
      end,

      --- Determine the main file to be compiled.
      --- @param path_of_buffer string Path to the current buffer.
      --- @return string The file to compile.
      get_main_file = function(path_of_buffer)
        return path_of_buffer
      end,
    },

    --- @brief Initializes the plugin and registers buffer-local interactions.
    --- @param _ table The plugin table (unused).
    --- @param opts table The options table from above.
    config = function(_, opts)
      local preview = require("typst-preview")
      preview.setup(opts)

      -- =======================================================================
      -- 1. BUFFER-LOCAL KEYBINDINGS
      -- =======================================================================

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TypstKeymaps", { clear = true }),
        pattern = "typst",
        callback = function()
          local b = vim.api.nvim_get_current_buf()
          local o = { buffer = b, silent = true }

          -- Start the previewer
          vim.keymap.set("n", "<leader>mt", "<cmd>TypstPreview<CR>", {
            buffer = b,
            desc = "Typst: Start Preview",
          })

          -- Stop the previewer
          vim.keymap.set("n", "<leader>mc", "<cmd>TypstPreviewStop<CR>", {
            buffer = b,
            desc = "Typst: Stop Preview",
          })

          -- Synchronize document scroll to cursor position
          vim.keymap.set("n", "<leader>ms", "<cmd>TypstPreviewSyncCursor<CR>", {
            buffer = b,
            desc = "Typst: Sync Cursor",
          })
        end,
      })

      -- =======================================================================
      -- 2. AUTOMATION (AUTO-SAVE)
      -- =======================================================================

      --- Trigger a silent write to prompt the previewer to refresh.
      vim.api.nvim_create_autocmd(
        { "TextChanged", "TextChangedI", "InsertLeave" },
        {
          group = vim.api.nvim_create_augroup("TypstAutoSave", { clear = true }),
          pattern = "*.typ",
          callback = function()
            vim.cmd("silent! write")
          end,
        }
      )
    end,
  },
}
