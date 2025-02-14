return {
  { "nvim-treesitter/nvim-treesitter-context" },
  { "wakatime/vim-wakatime", lazy = false },
  { "chaoren/vim-wordmotion" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "Bekaboo/dropbar.nvim" },
  { "kkharji/sqlite.lua" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { import = "plugins.telescope-extensions" },
  { import = "plugins.git-plugins" },
}
