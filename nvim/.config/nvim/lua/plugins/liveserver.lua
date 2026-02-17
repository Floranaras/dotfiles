return {
    {
        "barrett-ruth/live-server.nvim",
        build = "npm install -g live-server",
        config = function()
            vim.g.live_server = {
                args = { "--port=8080", "--no-css-inject", "--browser=brave browser"}
            }

            vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start Live Server" })
            vim.keymap.set("n", "<leader>lc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })

            vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
                pattern = { "*.html", "*.css", "*.js", "*.rs" },
                callback = function()
                    vim.cmd("silent! write")
                end,
            })
        end,
    },
}
