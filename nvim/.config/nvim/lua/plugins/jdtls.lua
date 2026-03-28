return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    -- 1. DEFINE PATHS (Fixes the 'nil value' error)
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local lombok_jar = mason_path .. "/lombok.jar"
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    -- Find the Equinox Launcher JAR dynamically
    local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    -- 2. CONSTRUCT COMMAND
    local cmd = {
      "java",
      "-javaagent:" .. lombok_jar, -- Using the local variable defined above
      "-Xmx2G",
      "-XX:+UseG1GC",
      "-jar", launcher_jar,
      "-configuration", mason_path .. "/config_mac", -- Change to /config_linux if not on Mac
      "-data", workspace_dir,

      -- Essential flags for Lombok on Java 17/21/25
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "--add-opens", "java.base/sun.nio.ch=ALL-UNNAMED",
      "--add-opens", "java.base/java.io=ALL-UNNAMED",
      "--add-opens", "java.base/java.util.concurrent=ALL-UNNAMED",
    }

    -- 3. JDTLS CONFIGURATION
    local config = {
      cmd = cmd,
      root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          format = { enabled = true },
          autobuild = { enabled = false }, -- Prevents freezing during refactors
        },
      },
      on_attach = function(client, bufnr)
        local opts = { silent = true, buffer = bufnr }
        
        -- LSP Mappings
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- THE NUCLEAR RESET KEYMAP
        -- Wipes the JDTLS cache and restarts the server
        vim.keymap.set("n", "<leader>jw", function()
          os.execute("rm -rf " .. workspace_dir)
          vim.cmd("JdtlsRestart")
          vim.notify("JDTLS: Workspace Wiped & Restarted", vim.log.levels.INFO)
        end, { desc = "[J]dtls [W]ipe cache", buffer = bufnr })

        -- Auto-format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end,
    }

    -- 4. START
    require("jdtls").start_or_attach(config)
  end,
}
