local is_diff = vim.tbl_contains(vim.v.argv, "-d") or vim.tbl_contains(vim.v.argv, "--diff")

return {
  "lewis6991/gitsigns.nvim",
  enabled = not is_diff,
}
