return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Cross-platform path detection (robust version)
        local function get_jdtls_paths()
            -- Method 1: Check Mason data directory directly (most reliable)
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
            local jdtls_bin = mason_path .. "/bin/jdtls"
            local lombok_jar = mason_path .. "/lombok.jar"

            if vim.fn.executable(jdtls_bin) == 1 then
                return {
                    jdtls_bin = jdtls_bin,
                    lombok_jar = vim.fn.filereadable(lombok_jar) == 1 and lombok_jar or nil,
                }
            end

            -- Method 2: Try Mason registry API (if available)
            local registry_ok, mason_registry = pcall(require, "mason-registry")
            if registry_ok and mason_registry.is_installed("jdtls") then
                local pkg = mason_registry.get_package("jdtls")
                local install_path = pkg:get_install_path()

                return {
                    jdtls_bin = install_path .. "/bin/jdtls",
                    lombok_jar = install_path .. "/lombok.jar",
                }
            end

            -- Method 3: Fallback to system installations
            local system_paths = {
                -- Linux paths
                { bin = "jdtls", lombok = "/usr/share/java/lombok.jar" },
                { bin = "jdtls", lombok = "/usr/local/share/java/lombok.jar" },
                { bin = "/usr/bin/jdtls", lombok = "/usr/share/java/lombok.jar" },
                -- macOS Homebrew paths
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

        -- Auto-install JDTLS if Mason is available and it's not installed
        local function ensure_installed()
            local registry_ok, mason_registry = pcall(require, "mason-registry")
            if not registry_ok then
                return true -- Mason not ready, skip check
            end

            if not mason_registry.is_installed("jdtls") then
                vim.notify("Installing jdtls via Mason...", vim.log.levels.INFO)
                vim.cmd("MasonInstall jdtls")
                return false
            end
            return true
        end

        -- Setup JDTLS for Java files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- Try to auto-install
                if not ensure_installed() then
                    vim.notify("Restart Neovim after jdtls installation completes", vim.log.levels.INFO)
                    return
                end

                -- Get paths
                local paths = get_jdtls_paths()

                if not paths then
                    vim.notify(
                        "JDTLS not found. Run: :MasonInstall jdtls",
                        vim.log.levels.WARN
                    )
                    return
                end

                -- Project-specific workspace (prevents conflicts)
                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

                -- Ensure workspace directory exists
                vim.fn.mkdir(workspace_dir, 'p')

                -- Build command
                local cmd = { paths.jdtls_bin, '-data', workspace_dir }

                if paths.lombok_jar then
                    table.insert(cmd, '--jvm-arg=-javaagent:' .. paths.lombok_jar)
                end

                -- Find project root
                local root_markers = { 'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle' }
                local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])

                -- JDTLS configuration
                local config = {
                    cmd = cmd,
                    root_dir = root_dir,

                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            contentProvider = { preferred = 'fernflower' },
                            configuration = {
                                runtimes = {}
                            }
                        }
                    },

                    init_options = {
                        bundles = {}
                    },

                    on_attach = function(client, bufnr)
                        local opts = { noremap = true, silent = true, buffer = bufnr }

                        -- Essential keybindings
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

                        -- Format on save (optional - comment out if you don't want this)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end,
                }

                -- Start or attach JDTLS
                local jdtls_ok, jdtls = pcall(require, 'jdtls')
                if jdtls_ok then
                    jdtls.start_or_attach(config)
                else
                    vim.notify("nvim-jdtls not loaded", vim.log.levels.ERROR)
                end
            end,
        })

        -- User commands
        vim.api.nvim_create_user_command("JdtlsRestart", function()
            vim.cmd("LspRestart")
        end, { desc = "Restart JDTLS" })

        vim.api.nvim_create_user_command("JdtlsInstall", function()
            vim.cmd("MasonInstall jdtls")
        end, { desc = "Install JDTLS via Mason" })
    end,
}
