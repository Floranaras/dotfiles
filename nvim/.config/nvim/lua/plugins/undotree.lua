--- @file undotree.lua
--- @brief Visualizes the undo history tree for easier navigation.
--- Neovim tracks a tree of changes rather than a linear list; this plugin
--- provides a side panel to navigate those branches and recover lost edits.

return {
  "mbbill/undotree",
  --- @brief Configures the global shortcut to toggle the undo tree panel.
  config = function()
    -- Toggle the visual undo tree window.
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
      desc = "Toggle Undotree Panel",
    })
  end,
}
