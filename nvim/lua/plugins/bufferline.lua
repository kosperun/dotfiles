return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  keys = {
    -- change the keymap to free bl/br for my custom functions
    { "<leader>bl", false },
    { "<leader>br", false },
    { "<leader>bL", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
    { "<leader>bR", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
  },
}
