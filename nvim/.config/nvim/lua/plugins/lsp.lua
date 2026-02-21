return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls", "tailwindcss", "html", "ts_ls" },
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()

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

            vim.lsp.config.html = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                root_markers = { ".git", "package.json" },
                capabilities = capabilities,
                init_options = {
                    provideFormatter = true,
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                    configurationSection = { "html", "css", "javascript" },
                },
            }

            vim.lsp.config.ts_ls = {
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                root_markers = { ".git", "package.json", "tsconfig.json" },
                capabilities = capabilities,
            }

            -- Enable all configured LSP servers
            vim.lsp.enable("clangd")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("tailwindcss")
            vim.lsp.enable("html")
            vim.lsp.enable("ts_ls")

            -- LSP Keybindings - attached when LSP connects to buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
                end,
            })
        end,
    },

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
                        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                    end,
                },
            })
        end,
    },
}
