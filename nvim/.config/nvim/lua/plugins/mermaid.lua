--- @file mermaid.lua
--- @brief Browser-based Markdown previewer with Mermaid and KaTeX support.
--- Unlike Peek, this plugin runs in your external browser and is highly
--- compatible with complex Mermaid diagrams and LaTeX math.

return {
  {
    "iamcco/markdown-preview.nvim",
    -- Load only when these commands are called
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    -- Load for markdown filetypes
    ft = { "markdown" },
    -- Build step to install node dependencies
    build = "cd app && npx --yes yarn install",

    -- =========================================================================
    -- 1. KEYBINDINGS (Lazy-loaded)
    -- =========================================================================
    keys = {
      {
        "<leader>mm",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Toggle Markdown Preview",
      },
    },

    -- =========================================================================
    -- 2. PLUGIN CONFIGURATION
    -- =========================================================================
    --- @brief Configure global variables for the preview engine.
    config = function()
      -- Do not start the preview automatically on file entry.
      vim.g.mkdp_auto_start = 0

      -- Automatically close the browser tab when the buffer is closed.
      vim.g.mkdp_auto_close = 1

      -- Force a dark theme for the rendered output.
      vim.g.mkdp_theme = "dark"

      -- Use a fixed port to prevent dynamic allocation issues.
      vim.g.mkdp_port = "8081"

      -- Parser and renderer options.
      vim.g.mkdp_preview_options = {
        mkit = {},  -- markdown-it options
        katex = {}, -- KaTeX for math
        uml = {},   -- PlantUML support
        maid = {},  -- Mermaid diagrams support
      }
    end,
  },
}
