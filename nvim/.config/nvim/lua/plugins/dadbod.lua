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

            -- Optional: Save queries in a specific directory
            vim.g.db_ui_save_location = vim.fn.expand("~/sql_queries")

            -- Auto-execute on save (saves and executes queries automatically)
            vim.g.db_ui_execute_on_save = 1

            -- Auto-save queries
            vim.g.db_ui_auto_execute_table_helpers = 1

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

            -- CRITICAL: Auto-save DBUI query buffers
            vim.api.nvim_create_autocmd("BufWriteCmd", {
                pattern = "*.dbout,*.sql",
                callback = function()
                    local bufname = vim.api.nvim_buf_get_name(0)

                    -- Check if it's a DBUI buffer without a proper filename
                    if bufname:match("^dbui://") or bufname == "" then
                        local save_dir = vim.fn.stdpath("data") .. "/db_ui"
                        vim.fn.mkdir(save_dir, "p")

                        -- Generate filename with timestamp
                        local timestamp = os.date("%Y%m%d_%H%M%S")
                        local filename = save_dir .. "/query_" .. timestamp .. ".sql"

                        -- Get buffer content
                        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

                        -- Write to file
                        vim.fn.writefile(lines, filename)

                        -- Update buffer name to the saved file
                        vim.cmd("file " .. filename)
                        vim.bo.modified = false

                        print("Query saved: " .. filename)
                    else
                        -- Normal save for regular files
                        vim.cmd("write!")
                    end
                end,
            })

            -- Auto-save on buffer leave for DBUI buffers
            vim.api.nvim_create_autocmd("BufLeave", {
                pattern = "*",
                callback = function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    local ft = vim.bo.filetype

                    if (ft == "sql" or ft == "mysql" or ft == "plsql") and vim.bo.modified then
                        if bufname:match("^dbui://") or bufname == "" then
                            -- Trigger our custom save
                            vim.cmd("silent! write")
                        else
                            -- Regular file save
                            vim.cmd("silent! write")
                        end
                    end
                end,
            })

            -- Better keybindings for SQL buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    vim.keymap.set("n", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })
                    vim.keymap.set("v", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })

                    -- Save current query to sql_queries directory
                    vim.keymap.set("n", "<leader>ss", function()
                        local save_dir = vim.fn.expand("~/sql_queries")
                        vim.fn.mkdir(save_dir, "p")

                        local timestamp = os.date("%Y%m%d_%H%M%S")
                        local filename = save_dir .. "/query_" .. timestamp .. ".sql"

                        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                        vim.fn.writefile(lines, filename)

                        print("Query saved: " .. filename)
                    end, { buffer = true, desc = "Save Query" })
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
