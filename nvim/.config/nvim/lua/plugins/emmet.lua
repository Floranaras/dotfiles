--- @file emmet.lua
--- @brief Emmet abbreviation expansion for faster HTML/CSS/JSX workflow.
--- This module configures the Emmet leader key and enables JSX support
--- for JavaScript buffers.

return {
  "mattn/emmet-vim",
  -- Supported filetypes for Emmet expansion
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescriptreact",
  },
  --- @brief Configure global Emmet settings.
  config = function()
    -- Set the expansion leader key to <C-y>
    -- Default trigger is <C-y>, (comma)
    vim.g.user_emmet_leader_key = "<C-y>"

    -- Configure specific language extensions
    vim.g.user_emmet_settings = {
      javascript = {
        -- Treat standard JS files as JSX for Emmet expansion
        extends = "jsx",
      },
    }
  end,
}
