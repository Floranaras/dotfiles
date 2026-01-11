return {
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("colorizer").setup({
                "*",
                css = { rgb_fn = true },
                html = { names = false },
            }, {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
            })

            vim.keymap.set("n", "<leader>ct", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                pattern = { "*.css", "*.scss", "*.html", "*.jsx", "*.tsx" },
                callback = function()
                    vim.cmd("ColorizerAttachToBuffer")
                end,
            })
        end,
    },
}
