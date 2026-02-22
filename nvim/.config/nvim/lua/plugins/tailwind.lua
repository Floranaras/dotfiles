--- @file colorizer.lua
--- @brief Configuration for color previews in buffers and completion menus.
--- This module enables color highlighting for hex codes, CSS functions,
--- and Tailwind classes both in the source code and autocomplete.

return {
  -- ===========================================================================
  -- 1. NVIM-COLORIZER (Buffer Highlighting)
  -- ===========================================================================
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        tailwind = true,   -- Enable tailwind colors
        RGB = true,        -- #RGB hex codes
        RRGGBB = true,     -- #RRGGBB hex codes
        names = false,     -- Disable "Name" colors (e.g. "Blue")
        RRGGBBAA = true,   -- #RRGGBBAA hex codes
        rgb_fn = true,     -- CSS rgb() and rgba() functions
        hsl_fn = true,     -- CSS hsl() and hsla() functions
        css = true,        -- Enable all CSS features
        css_fn = true,     -- Enable all CSS functions
        mode = "background",
        virtualtext = "■",
      },
    },
  },

  -- ===========================================================================
  -- 2. NVIM-CMP TAILWIND INTEGRATION
  -- ===========================================================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    --- @brief Extends existing cmp formatting to include Tailwind color icons.
    --- @param _ table The plugin table (unused).
    --- @param opts table The current CMP options table to be modified.
    --- @return table The modified options table.
    opts = function(_, opts)
      local format_kinds = opts.formatting and opts.formatting.format

      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, item)
        -- Call previous formatter if it exists
        if format_kinds then
          format_kinds(entry, item)
        end

        -- Add Tailwind CSS color swatches to completion menu
        local tw_colorizer = require("tailwindcss-colorizer-cmp")
        return tw_colorizer.formatter(entry, item)
      end

      return opts
    end,
  },
}
