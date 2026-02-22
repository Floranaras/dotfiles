--- @file jdtls.lua
--- @brief Comprehensive Java development setup using nvim-jdtls.
--- Features cross-platform path detection, Mason integration,
--- auto-installation, and debugging support.

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-dap",
  },
  --- @brief Initializes JDTLS when a Java file is opened.
  config = function()
    -- =========================================================================
    -- 1. UTILITY FUNCTIONS
    -- =========================================================================

    --- Detect JDTLS and Lombok paths across different installation methods.
    --- @return table|nil Paths for JDTLS binary and Lombok JAR.
    local function get_jdtls_paths()
      local data_path = vim.fn.stdpath("data")
      local mason_path = data_path .. "/mason/packages/jdtls"
      local jdtls_bin = mason_path .. "/bin/jdtls"
      local lombok_jar = mason_path .. "/lombok.jar"

      -- Priority 1: Direct Mason path check
      if vim.fn.executable(jdtls_bin) == 1 then
        return {
          jdtls_bin = jdtls_bin,
          lombok_jar = vim.fn.filereadable(lombok_jar) == 1
            and lombok_jar or nil,
        }
      end

      -- Priority 2: Mason Registry API
      local ok, registry = pcall(require, "mason-registry")
      if ok and registry.is_installed("jdtls") then
        local pkg = registry.get_package("jdtls")
        local path = pkg:get_install_path()
        return {
          jdtls_bin = path .. "/bin/jdtls",
          lombok_jar = path .. "/lombok.jar",
        }
      end

      -- Priority 3: System-specific fallbacks
      local system_paths = {
        {
          bin = "/opt/homebrew/opt/jdtls/bin/jdtls",
          lombok = "/opt/homebrew/share/java/lombok.jar",
        },
        {
          bin = "/usr/bin/jdtls",
          lombok = "/usr/share/java/lombok.jar",
        },
      }

      for _, ps in ipairs(system_paths) do
        if vim.fn.executable(ps.bin) == 1 then
          local l_path = vim.fn.filereadable(ps.lombok) == 1
            and ps.lombok or nil
          return { jdtls_bin = ps.bin, lombok_jar = l_path }
        end
      end
      return nil
    end

    --- Ensure JDTLS is installed via Mason.
    --- @return boolean True if ready, false if installation triggered.
    local function ensure_installed()
      local ok, registry = pcall(require, "mason-registry")
      if not ok then return true end
      if not registry.is_installed("jdtls") then
        vim.notify("Installing jdtls via Mason...", vim.log.levels.INFO)
        vim.cmd("MasonInstall jdtls")
        return false
      end
      return true
    end

    -- =========================================================================
    -- 2. AUTOCOMMANDS & LSP SETUP
    -- =========================================================================

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        if not ensure_installed() then
          vim.notify("Restart Neovim after install", vim.log.levels.INFO)
          return
        end

        local paths = get_jdtls_paths()
        if not paths then
          vim.notify("JDTLS not found.", vim.log.levels.WARN)
          return
        end

        -- Unique workspace directory per project
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("cache")
          .. "/jdtls-workspace/" .. project_name
        vim.fn.mkdir(workspace_dir, "p")

        -- Construct command
        local cmd = { paths.jdtls_bin, "-data", workspace_dir }
        if paths.lombok_jar then
          table.insert(cmd, "--jvm-arg=-javaagent:" .. paths.lombok_jar)
        end

        -- Detect project root
        local markers = { "gradlew", ".git", "mvnw", "pom.xml", "build.gradle" }
        local root_dir = vim.fs.dirname(
          vim.fs.find(markers, { upward = true })[1]
        )

        -- Debug adapter bundle path
        local mason_pkg = vim.fn.stdpath("data") .. "/mason/packages"
        local debug_path = mason_pkg .. "/java-debug-adapter/extension/server"
        local debug_jar = vim.fn.glob(
          debug_path .. "/com.microsoft.java.debug.plugin-*.jar",
          true
        )

        -- JDTLS Specific Configuration
        local config = {
          cmd = cmd,
          root_dir = root_dir,
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
            },
          },
          init_options = { bundles = { debug_jar } },
          on_attach = function(_, bufnr)
            local jdtls = require("jdtls")
            jdtls.setup_dap({ hotcodereplace = "auto" })

            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- LSP Mappings
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- Java specific Test/Debug mappings
            vim.keymap.set("n", "<leader>df", jdtls.test_class, opts)
            vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, opts)

            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function() vim.lsp.buf.format({ async = false }) end,
            })
          end,
        }

        require("jdtls").start_or_attach(config)
      end,
    })

    -- =========================================================================
    -- 3. USER COMMANDS
    -- =========================================================================

    vim.api.nvim_create_user_command("JdtlsRestart", "LspRestart", {
      desc = "Restart JDTLS",
    })

    vim.api.nvim_create_user_command("JdtlsInstall", "MasonInstall jdtls", {
      desc = "Install JDTLS via Mason",
    })
  end,
}
