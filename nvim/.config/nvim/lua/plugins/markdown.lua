--- @file markdown.lua
--- @brief Markdown preview configuration using peek.nvim.
--- Provides a live-updating webview for Markdown files with synchronized
--- scrolling and dark theme support.

return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",

    -- =========================================================================
    -- 1. KEYBINDINGS (Lazy-loaded)
    -- =========================================================================
    keys = {
      {
        "<leader>md",
        function() require("peek").open() end,
        desc = "Peek (Markdown Preview)",
      },
      {
        "<leader>mc",
        function() require("peek").close() end,
        desc = "Peek Close",
      },
    },

    -- =========================================================================
    -- 2. PLUGIN CONFIGURATION
    -- =========================================================================
    --- @brief Initializes the previewer and sets up user commands.
    config = function()
      local peek = require("peek")

      -- Register standard Neovim commands for the previewer.
      vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
      vim.api.nvim_create_user_command("PeekClose", peek.close, {})

      -- Configure peek behavior and UI properties.
      peek.setup({
        auto_load = true,        -- Automatically load preview on file open
        close_on_bdelete = true, -- Close preview when buffer is deleted
        syntax = true,           -- Enable syntax highlighting in preview
        theme = "dark",          -- Use dark mode theme
        update_on_change = true, -- Live update as you type
        app = "webview",         -- Backend application to use
        filetype = { "markdown" },
        throttle_at = 200000,    -- File size threshold for throttling
        throttle_time = "auto",  -- Dynamic update throttling
      })
    end,
  },
}
