--- @file live-server.lua
--- @brief Live preview server configuration for web development.
--- This module integrates live-server with Neovim, featuring
--- custom browser settings and automated saving for hot-reloading.

return {
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    --- @brief Configures server arguments and hot-reload triggers.
    config = function()
      vim.g.live_server = {
        args = {
          "--port=6767",
          "--no-css-inject",
          "--browser=brave browser",
        },
      }

      -- 1. KEYBINDINGS
      vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", {
        desc = "Start Live Server",
      })

      vim.keymap.set("n", "<leader>lc", ":LiveServerStop<CR>", {
        desc = "Stop Live Server",
      })

      -- 2. AUTOMATION (AUTO-SAVE)
     vim.api.nvim_create_autocmd(
        { "TextChanged", "TextChangedI", "InsertLeave" },
        {
          pattern = {
            "*.html",
            "*.css",
            "*.js",
          },
          callback = function()
            vim.cmd("silent! write")
          end,
        }
      )
    end,
  },
}
