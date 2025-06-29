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
-- COPY BUFFERS INTO SPLIT
-- ##########################################################################################

vim.keymap.set("n", "<leader>bl", function()
  vim.api.nvim_set_current_buf(vim.fn.winbufnr(vim.fn.winnr("l")))
end, { desc = "Copy buffer from right split (CUSTOM)" })

vim.keymap.set("n", "<leader>bh", function()
  vim.api.nvim_set_current_buf(vim.fn.winbufnr(vim.fn.winnr("h")))
end, { desc = "Copy buffer from left split (CUSTOM)" })

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
vim.api.nvim_set_keymap("n", "<leader>bs", "<cmd>lua SwapBuffers()<CR>", { desc = "Swap split buffers (CUSTOM)" })

-- ############################################################################
-- Go to definition in another split
-- ############################################################################
function GoToDefinitionInSplit()
  local current_win = vim.api.nvim_get_current_win()

  -- Try to find an existing split
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local target_win = nil

  for _, win in ipairs(wins) do
    if win ~= current_win then
      target_win = win
      break
    end
  end

  -- Create vsplit if needed
  if not target_win then
    vim.cmd("vsplit")
    target_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(current_win)
  end

  -- Find encoding used by the first LSP client
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local encoding = "utf-8" -- fallback
  if #clients > 0 and clients[1].offset_encoding then
    encoding = clients[1].offset_encoding
  end

  local params = vim.lsp.util.make_position_params(encoding)

  -- Custom handler for split
  local function handler(_, result, ctx, _)
    if not result or vim.tbl_isempty(result) then
      vim.notify("No definition found", vim.log.levels.INFO)
      return
    end

    local util = vim.lsp.util
    local location = result[1] or result
    vim.api.nvim_set_current_win(target_win)
    util.jump_to_location(location, encoding)
  end

  -- Request LSP definition
  vim.lsp.buf_request(0, "textDocument/definition", params, handler)
end

vim.keymap.set("n", "ga", GoToDefinitionInSplit, {
  desc = "Go to definition in existing split (no warnings)",
  silent = true,
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
  "<leader>yf",
  ":lua copy_paths_to_clipboard()<CR>",
  { desc = "Copy buffer's path (CUSTOM)", noremap = true, silent = true }
)

-- ##########################################################################################
-- COPY PYTHON METHOD/CLASS FULL PATH (pytest style - full filepath::Class::method)
-- ##########################################################################################
vim.keymap.set("n", "<leader>yt", function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  local class_name = nil
  local function_name = nil

  while node do
    if node:type() == "function_definition" and not function_name then
      local name_node = node:field("name")[1]
      if name_node then
        function_name = vim.treesitter.get_node_text(name_node, 0)
      end
    elseif node:type() == "class_definition" and not class_name then
      local name_node = node:field("name")[1]
      if name_node then
        class_name = vim.treesitter.get_node_text(name_node, 0)
      end
    end
    node = node:parent()
  end

  local relpath = vim.fn.expand("%")
  local test_path = relpath
  if class_name then
    test_path = test_path .. "::" .. class_name
  end
  if function_name then
    test_path = test_path .. "::" .. function_name
  end

  if not function_name then
    print("⚠️ Could not determine function name.")
    return
  end

  vim.fn.setreg("+", test_path)
  print("✅ Copied test path: " .. test_path)
end, { desc = "Copy pytest test path using treesitter (CUSTOM)", silent = true })
-- local docker_cmd = "docker exec -it my_app_container pytest " .. test_path
-- vim.fn.setreg("+", docker_cmd)
-- print("Copied: " .. docker_cmd)

-- Optional: Run in terminal
-- vim.cmd("split | terminal " .. docker_cmd)
-- end, { desc = "Run pytest in Docker using Tree-sitter", silent = true })
