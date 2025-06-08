return {
  "sainnhe/sonokai",
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.sonokai_enable_italic = true
    vim.cmd([[
  augroup CustomHighlights
    autocmd!
    autocmd ColorScheme sonokai highlight Visual guibg=#98938a
    autocmd ColorScheme sonokai highlight MatchParen guibg=#7f8490 guifg=#ffaf87
    autocmd ColorScheme sonokai highlight Normal guibg=#181819
    autocmd ColorScheme sonokai highlight SnacksPickerPathHidden guifg=#9ca0a4
    autocmd ColorScheme sonokai highlight SnacksPickerPathIgnored guifg=#fd6883
    autocmd ColorScheme sonokai highlight SnacksPickerGitStatusUntracked guifg=#7f8490
    " autocmd FileType markdown colorscheme cyberdream
    " autocmd BufLeave *.md if &ft == 'markdown' | colorscheme sonokai | endif
    " autocmd BufEnter * if &ft != 'markdown' | colorscheme sonokai | endif
  augroup END
]])
    vim.cmd.colorscheme("sonokai")
  end,
}
