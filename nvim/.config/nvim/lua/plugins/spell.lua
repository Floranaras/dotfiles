return {
    -- Simple autocorrect spell checking with cmp-spell
    {
        "f3fora/cmp-spell",
        dependencies = { "hrsh7th/nvim-cmp" },
    },
    
    -- Spell checking configuration
    {
        "spell-config",
        dir = vim.fn.stdpath("config"),
        config = function()
            -- Enable spell checking for text files
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "typst", "markdown", "text", "tex" },
                callback = function()
                    -- Enable native spell checking
                    vim.opt_local.spell = true
                    vim.opt_local.spelllang = "en_us"
                    
                    -- Add spell source to nvim-cmp for autocomplete corrections
                    local cmp = require('cmp')
                    cmp.setup.buffer({
                        sources = cmp.config.sources({
                            { 
                                name = 'spell',
                                option = {
                                    keep_all_entries = false,
                                    enable_in_context = function()
                                        return true
                                    end,
                                }
                            },
                            { name = 'buffer' },
                            { name = 'path' },
                        })
                    })
                    
                    -- Keybindings for spell checking
                    local opts = { buffer = true, silent = true }
                    
                    -- Toggle spell check
                    vim.keymap.set('n', '<leader>ss', function()
                        vim.opt_local.spell = not vim.opt_local.spell:get()
                        print("Spell check: " .. (vim.opt_local.spell:get() and "ON" or "OFF"))
                    end, { buffer = true, desc = "Toggle spell check" })
                    
                    -- Add word to dictionary
                    vim.keymap.set('n', '<leader>sa', 'zg', opts)
                    
                    -- Show spell suggestions menu
                    vim.keymap.set('n', '<leader>sc', 'z=', opts)
                    
                    -- Jump to next/previous misspelled word
                    vim.keymap.set('n', ']s', ']s', opts)
                    vim.keymap.set('n', '[s', '[s', opts)
                end,
            })
            
            -- Customize spell highlighting colors
            vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = '#f38ba8' })
            vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = '#fab387' })
        end,
    },
}
