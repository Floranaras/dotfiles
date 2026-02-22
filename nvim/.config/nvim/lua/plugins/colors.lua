--- @file colors.lua
--- @brief Configuration for UI themes and appearance.
--- This file defines theme-specific overrides (like transparency) and
--- configures the TokyoNight and Rose-Pine colorschemes.

--- Apply a colorscheme and force transparency on floating windows and buffers.
-- @param color string|nil The colorscheme name (defaults to "rose-pine").
function ColorMyPencils(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)

  -- Ensure background is transparent for the main editor window.
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

  -- Ensure background is transparent for floating windows (LSP, menus, etc).
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  -- ===========================================================================
  -- 1. TOKYONIGHT CONFIGURATION
  -- ===========================================================================
  {
    "folke/tokyonight.nvim",
    --- @brief Configures TokyoNight with a dark "Storm" aesthetic.
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
      })
    end,
  },

  -- ===========================================================================
  -- 2. ROSE-PINE CONFIGURATION (PRIMARY THEME)
  -- ===========================================================================
  {
    "rose-pine/neovim",
    name = "rose-pine",
    --- @brief Configures Rose-Pine and triggers the global transparency hook.
    config = function()
      require("rose-pine").setup({
        disable_background = true,
      })

      -- Set the active colorscheme to rose-pine by default.
      vim.cmd("colorscheme rose-pine")

      -- Execute transparency overrides.
      ColorMyPencils()
    end,
  },
}
