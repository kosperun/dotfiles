return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.cmd("highlight default link gitblame SpecialComment")
    require("gitblame").setup({ enabled = true })
  end,
  keys = {
    { "<leader>gt", "<cmd>GitBlameToggle<cr>", desc = "Git Blame Toggle" },
  },
}
