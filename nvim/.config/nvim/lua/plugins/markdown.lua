return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    keys  = {
      { "<leader>mp", function() require("peek").open() end,  desc = "Peek: Open preview" },
      { "<leader>mc", function() require("peek").close() end, desc = "Peek: Close preview" },
    },
    config = function()
      local peek = require("peek")

      vim.api.nvim_create_user_command("PeekOpen",  peek.open,  {})
      vim.api.nvim_create_user_command("PeekClose", peek.close, {})

      peek.setup({
        auto_load        = true,
        close_on_bdelete = true,
        syntax           = true,
        theme            = "dark",
        update_on_change = true,
        app              = "webview",
        filetype         = { "markdown" },
        throttle_at      = 200000,
        throttle_time    = "auto",
      })
    end,
  },
}
