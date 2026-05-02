return {
  {
    "saghen/blink.cmp",
    version      = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "ribru17/blink-cmp-spell",
    },
    opts = {
      keymap = {
        preset = "default", -- C-n/C-p navigate, C-y accept, C-e dismiss
        ["<CR>"]      = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        accept        = { auto_brackets = { enabled = true } },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          spell = {
            name         = "Spell",
            module       = "blink-cmp-spell",
            score_offset = -3,
          },
        },
        -- Spell source only active in prose-heavy filetypes
        per_filetype = {
          markdown = { "lsp", "path", "snippets", "buffer", "spell" },
          typst    = { "lsp", "path", "snippets", "buffer", "spell" },
          tex      = { "lsp", "buffer", "spell" },
          text     = { "buffer", "spell" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
