return {
  {
    "folke/flash.nvim",
    enabled = true,
    opts = {
      -- Disable dimming screen when searching with flash
      highlight = {
        backdrop = false, -- this doesn't do what I'd expect (i.e. remove the comment-colored backdrop)
        groups = { backdrop = "" },
      },
      -- Disable flash for ftFT and revert to the vanilla vim behavior
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      -- { "S", mode = { "n", "x", "o" }, false },
      {
        "<C-s>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
