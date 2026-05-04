return {
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local orig_notify = vim.notify
      vim.notify = function(msg, ...)
        if type(msg) == "string" and msg:find("kotlin_ls quit with exit code") then
          return
        end
        return orig_notify(msg, ...)
      end

      local kotlin_lsp_base = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/kotlin-lsp")
      local dirs = vim.fn.glob(kotlin_lsp_base .. "/kotlin-server-*", false, true)
      local versioned = dirs[1] or kotlin_lsp_base
      vim.env.KOTLIN_LSP_DIR = versioned
      vim.env.JAVA_HOME = versioned .. "/jbr"

      require("kotlin").setup({
        root_markers = { "gradlew", ".git", "settings.gradle", "build.gradle.kts" },
        lsp = {
          cmd = { versioned .. "/bin/intellij-server", "--stdio" },
          on_exit = function(code, signal, client_id) end,
        },
      })

      vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        pattern = "*.kt",
        callback = function()
          vim.cmd("silent! w!")
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.kt",
        callback = function()
          vim.defer_fn(function()
            vim.bo.modified = false
          end, 1000)
        end,
      })
    end,
  },
}
