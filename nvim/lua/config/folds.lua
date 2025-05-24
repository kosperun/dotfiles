local M = {}

function M.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local count = vim.v.foldend - vim.v.foldstart + 1

  local icon = ""
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

return M
