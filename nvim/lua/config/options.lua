-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local constants = require("config.constants")

-- Make hidden and ignored files lighter
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = "#928374" })

vim.g.python3_host_prog = "~/venvs/.nvim-venv/bin/python"
vim.g.python_host_prog = "~/.venvs/.nvim-venv/bin/python"
vim.g.wordmotion_prefix = "\\"

vim.o.autoread = true
vim.o.colorcolumn = tostring(constants.max_line_length)
vim.o.conceallevel = 1
vim.o.foldmethod = "manual"
vim.o.foldtext = "v:lua.require'config.folds'.custom_fold_text()"
-- vim.o.statuscolumn = "%s %{v:lnum} %{v:relnum} "
