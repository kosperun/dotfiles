-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Trigger `checktime` on certain events to check if the file has changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "if mode() != 'c' | checktime | endif",
})

-- Notification after file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.cmd('echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None')
  end,
})
