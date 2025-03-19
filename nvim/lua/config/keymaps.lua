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
