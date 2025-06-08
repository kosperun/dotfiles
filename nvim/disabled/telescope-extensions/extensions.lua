return {
  {
    "prochri/telescope-picker-history-action",
    opts = true,
  },
  {
    "princejoogie/dir-telescope.nvim",
    config = function()
      require("dir-telescope").setup({
        hidden = false,
        no_ignore = false,
        show_preview = true,
      })
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
}
