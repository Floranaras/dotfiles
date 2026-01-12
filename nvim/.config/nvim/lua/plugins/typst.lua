return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        build = function()
            require("typst-preview").update()
        end,
        opts = {
            debug = false,

            dependencies_bin = {
                ["typst-preview"] = nil,
                ["websocat"] = nil,
            },

            get_root = function(path_of_main_file)
                return vim.fn.fnamemodify(path_of_main_file, ":p:h")
            end,

            get_main_file = function(path_of_buffer)
                return path_of_buffer
            end,
        },
        config = function(_, opts)
            require("typst-preview").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "typst",
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()

                    vim.keymap.set("n", "<leader>mt", function()
                        vim.cmd("TypstPreview")
                    end, { buffer = bufnr, desc = "Typst Preview" })

                    vim.keymap.set("n", "<leader>mc", function()
                        vim.cmd("TypstPreviewStop")
                    end, { buffer = bufnr, desc = "Typst Preview Stop" })

                    vim.keymap.set("n", "<leader>ms", function()
                        vim.cmd("TypstPreviewSyncCursor")
                    end, { buffer = bufnr, desc = "Typst Scroll to Cursor" })
                end,
            })

            vim.api.nvim_create_autocmd({
                "TextChanged",
                "TextChangedI",
                "InsertLeave" },
            {
                pattern = "*.typ",
                callback = function()
                    vim.cmd("silent! write")
                end,
            })
        end,
    },
}
