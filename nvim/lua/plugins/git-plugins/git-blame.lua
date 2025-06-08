return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  opts = {
    -- your configuration comes here
    date_format = "%Y-%b-%d %H:%M:%S %a (%r)",
  },
  keys = {
    { "<leader>gt", "<cmd>GitBlameToggle<cr>", desc = "Git Blame Toggle CUSTOM" },
  },
}
