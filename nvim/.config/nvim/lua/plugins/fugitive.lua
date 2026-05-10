return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

    local group = vim.api.nvim_create_augroup("callo_fugitive", {})

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group    = group,
      pattern  = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then return end

        local bufnr = vim.api.nvim_get_current_buf()

        vim.keymap.set("n", "<leader>p", function() vim.cmd.Git("push") end,
          { buffer = bufnr, remap = false, desc = "Git Push (Fugitive)" })
        vim.keymap.set("n", "<leader>P", function() vim.cmd.Git({ "pull", "--rebase" }) end,
          { buffer = bufnr, remap = false, desc = "Git Pull Rebase (Fugitive)" })
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ",
          { buffer = bufnr, remap = false, desc = "Git Push Origin (Fugitive)" })
      end,
    })

    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { desc = "Get diff from target (left)" })
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { desc = "Get diff from merge (right)" })
  end,
}
