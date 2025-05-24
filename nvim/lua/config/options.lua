-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.colorcolumn = "120" -- vertical line for line length
vim.o.statuscolumn = "%s %{v:lnum} %{v:relnum} "
vim.o.conceallevel = 1
vim.g.wordmotion_prefix = "\\"
vim.o.autoread = true
vim.o.foldmethod = "manual"
vim.o.foldtext = "v:lua.require'config.folds'.custom_fold_text()"

vim.g.python_host_prog = "~/.venvs/.nvim-venv/bin/python"
vim.g.python3_host_prog = "~/venvs/.nvim-venv/bin/python"
vim.opt.autoread = true
function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local count = vim.v.foldend - vim.v.foldstart + 1

  -- Bigger fold icon (can be any Unicode symbol or emoji)
  local icon = "" -- More noticeable than 

  -- Reserve space for icon + " ... [count lines]" + some padding
  local suffix = string.format(" ... [%d lines]", count)
  local max_width = 119
  local max_line_length = max_width - vim.fn.strdisplaywidth(icon .. suffix) - 1

  -- Trim line if too long
  local display_line = vim.fn.strcharpart(line, 0, max_line_length)
  if #line > #display_line then
    display_line = display_line .. "…"
  end

  return string.format(" %s %s%s", icon, display_line, suffix)
end

vim.opt.foldtext = "v:lua.custom_fold_text()"
