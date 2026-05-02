vim.filetype.add({ extension = { templ = "templ" } })

return {
  { "joerdav/templ.vim" },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "lua_ls", "tailwindcss", "html",
          "ts_ls", "gopls", "htmx", "rust_analyzer", "svelte", "templ",
        },
      })

      -- Set capabilities globally so every server inherits them without repetition
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config["clangd"] = {
        cmd         = { "clangd" },
        filetypes   = { "c", "cpp", "objc", "objcpp" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
      }

      vim.lsp.config["lua_ls"] = {
        cmd         = { "lua-language-server" },
        filetypes   = { "lua" },
        root_markers = { ".git" },
        settings    = { Lua = { diagnostics = { globals = { "vim" } } } },
      }

      vim.lsp.config["tailwindcss"] = {
        cmd       = { "tailwindcss-language-server", "--stdio" },
        filetypes = {
          "html", "css", "scss", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "templ", "rust",
        },
        root_markers = {
          "tailwind.config.js", "tailwind.config.ts",
          "tailwind.config.cjs", "package.json",
        },
        settings = {
          tailwindCSS = {
            includeLanguages = { rust = "html" },
            experimental = {
              classRegex = { 'class="([^"]*)"', 'class=([^,)]*)' },
            },
          },
        },
      }

      vim.lsp.config["html"] = {
        cmd       = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html", "templ", "rust" },
        root_markers = { ".git", "go.mod", "package.json", "Cargo.toml" },
        init_options = {
          provideFormatter    = true,
          embeddedLanguages   = { css = true, javascript = true },
          configurationSection = { "html", "css", "javascript" },
        },
        settings = {
          html = { format = { templated = true }, suggest = { html5 = true } },
        },
      }

      vim.lsp.config["ts_ls"] = {
        cmd       = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte",
        },
        root_markers = { ".git", "package.json", "tsconfig.json" },
      }

      vim.lsp.config["svelte"] = {
        cmd          = { "svelteserver", "--stdio" },
        filetypes    = { "svelte" },
        root_markers = { "svelte.config.js", "package.json", ".git" },
        -- Notify the svelte server when TS/JS files change so it re-checks types
        on_attach = function(client, _)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern  = { "*.ts", "*.js" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames          = { enabled = "literals" },
              parameterTypes          = { enabled = true },
              variableTypes           = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes  = { enabled = true },
              enumMemberValues         = { enabled = true },
            },
          },
        },
      }

      vim.lsp.config["gopls"] = {
        cmd          = { "gopls" },
        filetypes    = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders    = true,
            analyses           = { unusedparams = true },
          },
        },
      }

      vim.lsp.config["htmx"] = {
        cmd          = { "htmx-lsp" },
        filetypes    = { "html", "templ" },
        root_markers = { ".git" },
      }

      vim.lsp.config["templ"] = {
        cmd          = { "templ", "lsp" },
        filetypes    = { "templ" },
        root_markers = { "go.mod", ".git" },
      }

      vim.lsp.config["rust_analyzer"] = {
        cmd          = { "rust-analyzer" },
        filetypes    = { "rust" },
        root_markers = { "Cargo.toml", "Cargo.lock", ".git" },
        settings = {
          ["rust-analyzer"] = {
            check       = { command = "clippy" },
            checkOnSave = true,
            procMacro   = { enable = true }, -- required for view! macro in Leptos
            cargo       = { features = "all" },
          },
        },
      }

      vim.lsp.enable({
        "clangd", "lua_ls", "tailwindcss", "html",
        "ts_ls", "gopls", "htmx", "templ", "rust_analyzer", "svelte",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group    = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set("n", "gd",          vim.lsp.buf.definition,      opts)
          vim.keymap.set("n", "K",           vim.lsp.buf.hover,           opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float,   opts)
          vim.keymap.set("n", "[d",          vim.diagnostic.goto_prev,    opts)
          vim.keymap.set("n", "]d",          vim.diagnostic.goto_next,    opts)
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action,     opts)
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references,      opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename,          opts)
          vim.keymap.set("i", "<C-h>",       vim.lsp.buf.signature_help,  opts)
        end,
      })
    end,
  },

}
