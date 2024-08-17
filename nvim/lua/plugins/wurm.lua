return {
  "shadowburst/wurm.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>p",
      "<cmd>WurmPrev<cr>",
      desc = "Navigate to previous buffer",
    },
    {
      "<leader>n",
      "<cmd>WurmNext<cr>",
      desc = "Navigate to next buffer",
    },
  },
}
