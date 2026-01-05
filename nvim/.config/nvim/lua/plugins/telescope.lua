return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local has_telescope, telescope = pcall(require, 'telescope')
        if not has_telescope then
            return
        end

        local has_previewers, previewers_utils = pcall(require, 'telescope.previewers.utils')
        if has_previewers then
            local old_highlighter = previewers_utils.ts_highlighter
            previewers_utils.ts_highlighter = function(bufnr, ft)
                return false
            end
        end

        telescope.setup({
            defaults = {
                buffer_previewer_maker = function(filepath, bufnr, opts)
                    opts = opts or {}
                    vim.loop.fs_stat(filepath, function(_, stat)
                        if not stat then return end
                        if stat.size > 100000 then
                            return
                        end
                        vim.schedule(function()
                            local ok = pcall(vim.fn.readfile, filepath)
                            if ok then
                                vim.api.nvim_buf_call(bufnr, function()
                                    vim.cmd('setlocal syntax=on')
                                end)
                            end
                        end)
                    end)
                end,
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
