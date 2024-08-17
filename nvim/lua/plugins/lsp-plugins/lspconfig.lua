return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {
        settings = {
          python = {
            analysis = {
              extraPaths = { "~/kosperun/Django" },
            },
          },
        },
      },
    },
  },
}
