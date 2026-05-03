return {
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      vim.env.KOTLIN_LSP_DIR = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/kotlin-lsp")
      require("kotlin").setup({
        root_markers = { "gradlew", ".git", "settings.gradle", "build.gradle.kts" },
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
