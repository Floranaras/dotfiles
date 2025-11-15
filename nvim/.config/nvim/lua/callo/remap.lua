vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- PROJECT NAVIGATION SUPERPOWERS
-- Open file explorer at project root
vim.keymap.set("n", "<leader>pr", function()
    vim.cmd("Explore " .. vim.fn.getcwd())
end, { desc = "Project root explorer" })

-- Create new file in current directory
vim.keymap.set("n", "<leader>nf", function()
    local filename = vim.fn.input("New file (relative to current): ")
    if filename ~= "" then
        local current_dir = vim.fn.expand("%:p:h")
        vim.cmd("e " .. current_dir .. "/" .. filename)
    end
end, { desc = "New file in current dir" })

-- Create new file from project root
vim.keymap.set("n", "<leader>nF", function()
    local filename = vim.fn.input("New file (from root): ")
    if filename ~= "" then
        vim.cmd("e " .. vim.fn.getcwd() .. "/" .. filename)
    end
end, { desc = "New file from project root" })

-- Run gradle from anywhere
vim.keymap.set("n", "<leader>gr", function()
    vim.cmd("below terminal cd " .. vim.fn.getcwd() .. " && ./gradlew run")
end, { desc = "Gradle run" })

vim.keymap.set("n", "<leader>gb", function()
    vim.cmd("below terminal cd " .. vim.fn.getcwd() .. " && ./gradlew build")
end, { desc = "Gradle build" })

vim.keymap.set("n", "<leader>gt", function()
    vim.cmd("below terminal cd " .. vim.fn.getcwd() .. " && ./gradlew test")
end, { desc = "Gradle test" })

-- Quick terminal at project root
vim.keymap.set("n", "<leader>tt", function()
    vim.cmd("below terminal")
    vim.cmd("startinsert")
end, { desc = "Terminal at project root" })
