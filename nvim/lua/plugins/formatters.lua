return {
  "stevearc/conform.nvim",
  opts = {
    -- LazyVim will use these options when formatting with the conform.nvim formatter
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      python = { "isort", "black" },
      -- python = { "ruff" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      json = { "jq" },
    },
    -- The options you set here will be merged with the builtin formatters.
    -- You can also define any custom formatters here.
    formatters = {
      injected = { options = { ignore_errors = true } },
      black = {
        prepend_args = { "--line-length", "120" },
      },
      isort = {
        prepend_args = { "--profile", "black", "--line-length=120", "--trailing-comma", "--multi-line=3" },
      },
    },
  },
}
