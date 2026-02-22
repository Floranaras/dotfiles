--- @file fugitive.lua
--- @brief Git integration and workflow automation using vim-fugitive.
--- This module provides shortcuts for git status, pushing/pulling, and
--- efficient merge conflict resolution.

return {
  "tpope/vim-fugitive",
  --- @brief Configure fugitive keybindings and buffer-local automations.
  config = function()
    -- Open git status / summary window
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

    -- Create an augroup for fugitive-specific buffer logic
    local callo_fugitive = vim.api.nvim_create_augroup("callo_fugitive", {})
    local autocmd = vim.api.nvim_create_autocmd

    --- Set up buffer-local keymaps when entering a fugitive buffer.
    autocmd("BufWinEnter", {
      group = callo_fugitive,
      pattern = "*",
      callback = function()
        -- Only proceed if the current buffer is a fugitive window
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        -- Git push
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git("push")
        end, opts)

        -- Git pull with rebase
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git({ "pull", "--rebase" })
        end, opts)

        -- Quick command to push to origin and set upstream
        -- Note: Allows manual entry of the branch name.
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })

    -- =========================================================================
    -- MERGE CONFLICT RESOLUTION
    -- =========================================================================

    -- Get changes from the left (target) side during a merge conflict
    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")

    -- Get changes from the right (merge) side during a merge conflict
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  end,
}
