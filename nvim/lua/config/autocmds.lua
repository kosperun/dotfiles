-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ##########################################################################################
-- OPEN PYTHON FILE FROM TERMINAL
-- ##########################################################################################
-- Define the OpenFile function
function OpenFile()
  -- Get the current word under the cursor
  local file_path = vim.fn.getline(".")
  -- Extract the file path and line number if present
  local file, line, col = file_path:match("([^:]+):?(%d*):?(%d*):?.*")
  -- If file doesn't contain ".py", add ".py" extension unless it ends with ".py"
  if not file:find("%.py$") then
    file = file .. ".py"
  end
  -- Open the file
  vim.cmd("edit " .. file)
  -- If line number is specified, navigate to that line (and column if specified)
  if line ~= "" then
    vim.cmd("normal! " .. line .. "G")
    if col ~= "" then
      vim.cmd("normal! " .. col .. "|")
    end
  end
end
-- Function to set keymap in the terminal buffer
local function set_gf_keymap()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_keymap(buf, "n", "gf", "<cmd>lua OpenFile()<CR>", { noremap = true, silent = true })
end
-- Create an augroup
local toggleterm_augroup = vim.api.nvim_create_augroup("ToggleTermGFMapping", { clear = true })
-- Create an autocommand for TermOpen event
vim.api.nvim_create_autocmd("TermOpen", {
  group = toggleterm_augroup,
  pattern = "term://*toggleterm#*",
  callback = set_gf_keymap,
})

-- ##########################################################################################
-- Auto reload the buffer after file was changed elsewhere
-- ##########################################################################################
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

-- ##########################################################################################
-- READ CSV/TSV FILES AUTOMATICALLY
-- ##########################################################################################
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.csv", "*.tsv" },
  callback = function()
    require("csvview").enable()
  end,
})
