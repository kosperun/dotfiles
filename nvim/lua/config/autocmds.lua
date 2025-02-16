-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto reload the buffer after file was changed elsewhere
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

-- Auto-save buffer to file
local function clear_cmdarea()
  vim.defer_fn(function()
    vim.api.nvim_echo({}, false, {})
  end, 800)
end
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)

    -- Ensure the buffer has a valid file name (not a temporary or special buffer)
    if buf_name ~= "" and vim.bo.buflisted and vim.bo.modified then
      -- Check if the file exists before attempting to save
      local file_exists = vim.fn.filereadable(buf_name) == 1
      if file_exists then
        vim.cmd("silent w")

        local time = os.date("%I:%M %p")

        -- print nice colored msg
        vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. time } }, false, {})

        clear_cmdarea()
      end
    end
  end,
})
-- -- Disable autoformat for javascript files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "javascript" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.csv", "*.tsv" },
  callback = function()
    require("csvview").enable()
  end,
})
