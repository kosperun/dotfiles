-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("v", "<leader><C-a>", '"hy:%s/\\v<C-r>h//g<left><left>', { desc = "Change selection" })
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[c", "[czz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]c", "]czz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gU", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open commit URL" })
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- ##########################################################################################
-- SWAP BUFFERS IN SPLIT
-- ##########################################################################################
function SwapBuffers()
  if vim.fn.winnr("$") == 2 then
    local buf1 = vim.fn.winbufnr(1)
    local buf2 = vim.fn.winbufnr(2)
    vim.cmd("buffer " .. buf2)
    vim.cmd("wincmd w")
    vim.cmd("buffer " .. buf1)
    vim.cmd("wincmd w")
  else
    print("This function works only with two windows")
  end
end
vim.api.nvim_set_keymap("n", "<leader>bs", "<cmd>lua SwapBuffers()<CR>", { desc = "Swap split buffers" })

-- ##########################################################################################
-- DISPLAY NOTIFICATION WHEN SETTING MARKS
-- ##########################################################################################
-- Custom function to notify when a mark is set
-- nvim-notify was replaced by Snacks.notifier
-- local notify = require("notify")
local function notify_mark_set(mark)
  -- Get the current position
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  -- Show a notification with mark info
  -- notify(string.format("Mark '%s' set at line %d, column %d", mark, line, col), "info", { title = "Mark Set" })
  Snacks.notifier.notify(
    string.format("Mark '%s' set at line %d, column %d", mark, line, col),
    "info",
    { title = "Mark Set" }
  )
end
-- Map the 'm' command to trigger the notification
vim.keymap.set("n", "m", function()
  -- Capture the mark character
  local char = vim.fn.getcharstr()
  -- Set the mark using the captured character
  vim.cmd("normal! m" .. char)
  -- Notify the user about the mark
  notify_mark_set(char)
end, { noremap = true, silent = true })

-- ##########################################################################################
-- COPY CURRENT BUFFER PATHS TO CLIPBOARD
-- ##########################################################################################
function copy_paths_to_clipboard()
  -- Get current buffer's file information
  local filepath = vim.fn.expand("%:p") -- Absolute path
  local filename = vim.fn.expand("%:t") -- Filename (with extension)
  local modify = vim.fn.fnamemodify

  -- Calculate the relative path for Python imports
  local cwd = vim.fn.getcwd()
  local relative_path = modify(filepath, ":.") -- Relative path (CWD)
  local python_import_path = relative_path:gsub(cwd .. "/", ""):gsub("/", "."):gsub("%.py$", "")

  -- Results to show in the selection menu
  local results = {
    python_import_path, -- 1: Python import path
    relative_path, -- 2: Relative path (CWD)
    filename, -- 3: Filename
    modify(filename, ":r"), -- 4: Filename without extension
    filepath, -- 5: Absolute path
    modify(filepath, ":~"), -- 6: Relative path (HOME)
  }

  -- Show the choices in a modal-like interface
  vim.ui.select({
    "1. Python import path: " .. results[1],
    "2. Relative path (CWD): " .. results[2],
    "3. Filename: " .. results[3],
    "4. Filename without extension: " .. results[4],
    "5. Absolute path: " .. results[5],
    "6. Relative path (HOME): " .. results[6],
  }, { prompt = "Choose to copy to clipboard:" }, function(choice)
    if choice then
      local i = tonumber(choice:sub(1, 1))
      if i then
        local result = results[i]
        vim.fn.setreg("+", result) -- Copy to clipboard
        vim.notify("Copied: " .. result)
      else
        vim.notify("Invalid selection")
      end
    else
      vim.notify("Selection cancelled")
    end
  end)
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>P",
  ":lua copy_paths_to_clipboard()<CR>",
  { desc = "Copy buffer's path", noremap = true, silent = true }
)

-- ############################################################################
-- Go to definition in another split
-- ############################################################################
-- In your Neovim config (e.g., ~/.config/nvim/lua/your_config/init.lua)
function GoToDefinitionInSplit()
  -- Check how many windows are open
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local current_cursor_pos = vim.api.nvim_win_get_cursor(0)

  local current_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()

  local target_win

  -- If there are already splits, then take the next one and set buffer to current buffer
  if #wins >= 2 then
    for _, win_num in pairs(wins) do
      if win_num ~= current_win then
        target_win = win_num
      end
    end
  else
    target_win = current_win
    vim.cmd("vsplit")
  end

  -- Set buffer for new window
  vim.api.nvim_win_set_buf(target_win, current_buf)

  -- Copy cursor position to new window for lsp defintion
  vim.api.nvim_win_set_cursor(target_win, current_cursor_pos)

  -- Focus new window
  vim.api.nvim_set_current_win(target_win)

  -- Call lsp
  vim.lsp.buf.definition()
end

vim.api.nvim_set_keymap(
  "n",
  "ga",
  "<cmd>lua GoToDefinitionInSplit()<CR>",
  { desc = "Go to Definition in another split" }
)
