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
    autocmd ColorScheme sonokai highlight MatchParen guibg=#7f8490 guifg=#ffffff
    autocmd ColorScheme sonokai highlight Normal guibg=#181819
    autocmd ColorScheme sonokai highlight SnacksPickerPathHidden guifg=#9ca0a4
    autocmd ColorScheme sonokai highlight SnacksPickerPathIgnored guifg=#fd6883
    autocmd ColorScheme sonokai highlight SnacksPickerGitStatusUntracked guifg=#7f8490
    autocmd ColorScheme sonokai highlight LspReferenceRead guibg=#444b5d 
  augroup END
]])
    vim.cmd.colorscheme("sonokai")
  end,
}
