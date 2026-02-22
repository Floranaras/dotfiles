--- @file plenary.lua
--- @brief Essential Lua library containing utility functions for Neovim.
--- This module acts as a "Swiss Army knife" for Neovim plugin developers,
--- providing foundational functions for testing, async, and IO.

return {
  {
    "nvim-lua/plenary.nvim",
    -- Explicitly naming the plugin for consistent internal references.
    name = "plenary",
  },
}
