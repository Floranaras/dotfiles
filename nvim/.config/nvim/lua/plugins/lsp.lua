return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls", "tailwindcss" },
            })

            vim.lsp.config.clangd = {
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_markers = { ".git", "compile_commands.json" },
                capabilities = capabilities,
            }

            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".git" },
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            }

            -- Tailwind CSS LSP
            vim.lsp.config.tailwindcss = {
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                root_markers = { 
                    "tailwind.config.js", 
                    "tailwind.config.ts", 
                    "tailwind.config.cjs",
                    "package.json" 
                },
                capabilities = capabilities,
            }

            -- Enable LSP servers
            vim.lsp.enable("clangd")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("tailwindcss")

            -- LSP Keybindings
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
                end,
            })
        end,
    },

    -- Completion Configuration
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "roobert/tailwindcss-colorizer-cmp.nvim",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                }),
                formatting = {
                    format = function(entry, item)
                        -- Add Tailwind color squares
                        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                    end,
                },
            })
        end,
    },
}
