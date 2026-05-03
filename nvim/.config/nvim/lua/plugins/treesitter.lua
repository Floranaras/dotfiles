return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build  = ":TSUpdate",
  lazy   = false,
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

    local parsers = {
      "vimdoc", "javascript", "typescript", "c", "lua",
      "rust", "jsdoc", "bash", "html", "css", "tsx",
      "json", "go", "templ", "markdown", "markdown_inline",
      "glimmer", "svelte", "kotlin",
    }

    vim.defer_fn(function() ts.install(parsers) end, 0)

    -- Build the filetype list so we only enable treesitter for parsers we have
    local patterns = {}
    for _, parser in ipairs(parsers) do
      for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
        table.insert(patterns, ft)
      end
    end

    -- Use pcall so missing parsers don't crash on first launch before install completes
    vim.api.nvim_create_autocmd("FileType", {
      pattern  = patterns,
      callback = function()
        local ok = pcall(vim.treesitter.start)
        if ok then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    vim.treesitter.language.register("templ", "templ")
  end,
}
