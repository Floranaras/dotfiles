return {
    {
        "tpope/vim-dadbod",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod" },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- DBUI Configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 1
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            -- Show notifications
            vim.g.db_ui_show_help = 1
            vim.g.db_ui_use_nvim_notify = 1

            -- Save queries directory
            vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

            -- Don't auto-execute on save (execute manually with <leader>S)
            vim.g.db_ui_execute_on_save = 0

            -- Use the default table helpers
            vim.g.db_ui_table_helpers = {
                mysql = {
                    Count = "SELECT COUNT(*) FROM {table}",
                    Explain = "EXPLAIN {last_query}",
                },
            }

            -- Disable folds in result buffers for immediate visibility
            vim.g.db_ui_disable_fold = 1
        end,
        keys = {
            { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
            { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Database Buffer" },
            { "<leader>dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Database Buffer" },
            { "<leader>dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
        },
        config = function()
            -- Setup dadbod-completion for SQL autocomplete
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    require("cmp").setup.buffer({
                        sources = {
                            { name = "vim-dadbod-completion" },
                            { name = "buffer" },
                        },
                    })
                end,
            })

            -- Auto-open folds in DBUI result buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    vim.opt_local.foldenable = false
                    vim.opt_local.number = true
                    vim.opt_local.relativenumber = false
                end,
            })

            -- Better keybindings for SQL buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    vim.keymap.set("n", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
                    vim.keymap.set("v", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
                end,
            })

            -- Suppress modifiable warnings in result buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dbout",
                callback = function()
                    vim.opt_local.modifiable = false
                    vim.opt_local.readonly = true
                end,
            })
        end,
    },
}
