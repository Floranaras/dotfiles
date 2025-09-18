return {
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",

        keys = {
            { "<leader>md", function() require("peek").open() end, desc = "Peek (Markdown Preview)" },
            { "<leader>mc", function() require("peek").close() end, desc = "Peek Close" },
        },

        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

            require('peek').setup({
                auto_load = true,
                close_on_bdelete = true,
                syntax = true,
                theme = 'dark',
                update_on_change = true,
                app = 'webview',
                filetype = { 'markdown' },
                throttle_at = 200000,
                throttle_time = 'auto',
            })
        end,
    },
}
