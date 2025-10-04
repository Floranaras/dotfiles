return {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescriptreact" },
    config = function()
        vim.g.user_emmet_leader_key = '<C-y>'  -- Changed to Ctrl+y
        vim.g.user_emmet_settings = {
            javascript = {
                extends = 'jsx',
            },
        }
    end,
}
