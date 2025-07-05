return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "css",
      "dockerfile",
      "gitignore",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}
