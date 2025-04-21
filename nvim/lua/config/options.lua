-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true -- relative line numbers
vim.opt.colorcolumn = "120" -- vertical line for line length
vim.opt.statuscolumn = "%s %l %r "
vim.opt.conceallevel = 1
vim.g.wordmotion_prefix = "\\"
vim.g.markdown_folding = 1
vim.o.foldmethod = "manual"
vim.g.python_host_prog = "~/.venvs/.nvim-venv/bin/python"
vim.g.python3_host_prog = "~/venvs/.nvim-venv/bin/python"
vim.opt.autoread = true
vim.g.snacks_animate = false
