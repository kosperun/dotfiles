return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "python", "markdown", "markdown_inline" })
    opts.highlight = { enable = true }
  end,
}
