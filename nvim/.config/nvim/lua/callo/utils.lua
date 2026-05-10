local M = {}

function M.new_relative_file()
  local name = vim.fn.input("New file (relative to current): ")
  if name == "" then return end
  vim.cmd.edit(vim.fn.fnameescape(vim.fn.expand("%:p:h") .. "/" .. name))
end

function M.new_root_file()
  local name = vim.fn.input("New file (from root): ")
  if name == "" then return end
  vim.cmd.edit(vim.fn.fnameescape(vim.fn.getcwd() .. "/" .. name))
end

function M.gradle_cmd(task)
  vim.cmd("below terminal cd " .. vim.fn.shellescape(vim.fn.getcwd()) .. " && ./gradlew " .. task)
end

return M
