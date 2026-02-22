--- @file harpoon.lua
--- @brief Rapid file navigation and marking system.
--- Harpoon allows you to pin specific files to a persistent menu and 
--- jump between them instantly using dedicated hotkeys.

return {
  "theprimeagen/harpoon",
  --- @brief Configures markers and navigation shortcuts for Harpoon.
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- =========================================================================
    -- 1. MARKING & UI
    -- =========================================================================

    -- Mark the current file for the Harpoon list.
    vim.keymap.set("n", "<leader>a", mark.add_file)

    -- Toggle the visual menu to view and manage marked files.
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    -- =========================================================================
    -- 2. FAST NAVIGATION
    -- =========================================================================

    -- Navigate directly to specific marks (1 through 4).
    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(4) end)
  end,
}
