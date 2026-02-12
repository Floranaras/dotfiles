return {
    {
        "barrett-ruth/live-server.nvim",
        build = "npm install -g live-server",
        config = function()
            -- New configuration method
            vim.g.live_server = {
                args = { "--port=8080", "--no-css-inject" }
            }

            -- Keymaps
            vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start Live Server" })
            vim.keymap.set("n", "<leader>lc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })

            -- Auto-save for seamless updates
            vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
                pattern = { "*.html", "*.css", "*.js", "*.rs" },
                callback = function()
                    vim.cmd("silent! write")
                end,
            })
        end,
    },
}
