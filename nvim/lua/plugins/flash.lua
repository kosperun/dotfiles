return {
  {
    "folke/flash.nvim",
    enabled = true,
    opts = {
      -- Disable dimming screen when searching with flash
      -- highlight = {
      --   backdrop = false, -- this doesn't do what I'd expect (i.e. remove the comment-colored backdrop)
      --   groups = { backdrop = "" },
      -- },
      -- Disable flash for ftFT and revert to the vanilla vim behavior
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
      -- Jump to specific search result
      {
        "gs",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      -- Select code blocks based on syntax and treesitter
      {
        "gS",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      -- Jump to code blocks start-end. Taken from https://www.reddit.com/r/neovim/comments/1bl3dwz/whats_your_best_remap_for_flash_or_leap/
      {
        "zU",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            jump = { pos = "end" },
            label = { before = false, after = true, style = "overlay" },
          })
        end,
        desc = "Flash Treesitter",
      },

      {
        "zu",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            jump = { pos = "start" },
            label = { before = true, after = false, style = "overlay" },
          })
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
