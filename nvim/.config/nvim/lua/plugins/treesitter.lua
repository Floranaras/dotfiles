return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "vimdoc", "javascript", "typescript", "lua", "rust",
        "jsdoc", "bash", "html", "css", "tsx", "json", "go",
        "markdown", "markdown_inline", "kotlin", "svelte"
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })

    vim.treesitter.language.register("templ", "templ")
  end,
}
