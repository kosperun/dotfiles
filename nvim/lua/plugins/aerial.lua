return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>a", "<cmd>AerialToggle<CR>", desc = "Aerial (Code structure)" },
  },
  opts = {
    manage_folds = true,
    -- When you fold code with za, zo, or zc, update the aerial tree as well.
    link_folds_to_tree = false,
    -- Fold code when you open/collapse symbols in the tree.
    link_tree_to_folds = true,
    lazy_load = false,
    -- Could not get it to work with these events
    -- close_automatic_events= {'switch_buffer', 'unfocus'}
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require("aerial").setup(opts)
  end,
}
