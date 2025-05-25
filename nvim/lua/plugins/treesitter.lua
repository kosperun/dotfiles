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
        init_selection = "<tab>",
        node_incremental = "<tab>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}
