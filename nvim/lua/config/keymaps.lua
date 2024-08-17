-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[c", "[czz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]c", "]czz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gU", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open commit URL" })

-- Swap buffers in split
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
