return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "pyright",
      "black",
      "flake8",
      "ruff",
      -- "javascript",
      -- "prettier",
      -- code spell
      "codespell",
      -- "misspell",
      "cspell",
    },
  },
}
