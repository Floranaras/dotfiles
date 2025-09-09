return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    keys = {
        { "<leader>md", function() require("peek").open() end, desc = "Peek (Markdown Preview)" },
        { "<leader>mc", function() require("peek").close() end, desc = "Peek Close" },
    },
    config = function()
        require("peek").setup({
            auto_load = true,         -- automatically load preview when entering markdown buffer
            close_on_bufleave = true, -- close preview window on buffer leave
            syntax = true,            -- enable syntax highlighting
            theme = 'dark',           -- 'dark' or 'light' (GitHub style)
            update_on_change = true,  -- update preview on file change
            app = 'webview',          -- opens in a webview window
            filetype = { 'markdown' }, -- only for markdown files
        })
    end,
}
