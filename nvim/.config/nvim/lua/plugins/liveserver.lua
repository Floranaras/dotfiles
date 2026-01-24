return {
    {
        "barrett-ruth/live-server.nvim",
        build = "npm install -g live-server",
        config = function()
            require("live-server").setup({
                args = { "--port=8080", "--no-css-inject" }
            })

            vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start Live Server" })
            vim.keymap.set("n", "<leader>lc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })

            -- Auto-save frequently for seamless updates
            vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
                pattern = { "*.html", "*.css", "*.js"},
                callback = function()
                    vim.cmd("silent! write")
                end,
            })
        end,
    },
}
