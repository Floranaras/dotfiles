return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local function get_jdtls_paths()
            local mason_registry = require("mason-registry")

            if mason_registry.is_installed("jdtls") then
                local jdtls_pkg = mason_registry.get_package("jdtls")
                local install_path = jdtls_pkg:get_install_path()

                return {
                    jdtls_bin = install_path .. "/bin/jdtls",
                    lombok_jar = install_path .. "/lombok.jar",
                }
            end

            local system_paths = {
                { bin = "jdtls", lombok = "/usr/share/java/lombok.jar" },
                { bin = "jdtls", lombok = "/usr/local/share/java/lombok.jar" },
                { bin = "/opt/homebrew/opt/jdtls/bin/jdtls", lombok = "/opt/homebrew/share/java/lombok.jar" },
                { bin = "/usr/local/opt/jdtls/bin/jdtls", lombok = "/usr/local/share/java/lombok.jar" },
            }

            for _, path_set in ipairs(system_paths) do
                if vim.fn.executable(path_set.bin) == 1 then
                    local lombok = vim.fn.filereadable(path_set.lombok) == 1 and path_set.lombok or nil
                    return { jdtls_bin = path_set.bin, lombok_jar = lombok }
                end
            end

            return nil
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                local paths = get_jdtls_paths()

                if not paths then
                    vim.notify(
                        "JDTLS not found. Install via :MasonInstall jdtls",
                        vim.log.levels.ERROR
                    )
                    return
                end

                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

                vim.fn.mkdir(workspace_dir, 'p')

                local cmd = { paths.jdtls_bin, '-data', workspace_dir }

                if paths.lombok_jar then
                    table.insert(cmd, '--jvm-arg=-javaagent:' .. paths.lombok_jar)
                end

                local config = {
                    cmd = cmd,
                    root_dir = vim.fs.dirname(
                        vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle' }, { upward = true })[1]
                    ),

                    settings = {
                        java = {
                            configuration = {
                                runtimes = {
                                }
                            }
                        }
                    },

                    on_attach = function(client, bufnr)
                        local opts = { noremap = true, silent = true, buffer = bufnr }

                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end,
                }

                require('jdtls').start_or_attach(config)
            end,
        })

        vim.api.nvim_create_user_command("JdtlsRestart", function()
            vim.cmd("LspRestart")
        end, {})
    end,
}
