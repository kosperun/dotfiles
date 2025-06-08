return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    picker = {
      matcher = { frecency = true, history_bonus = true, ignorecase = false },
      formatters = {
        file = {
          -- whatever sane or insane value you need, default was 40
          truncate = 300,
        },
      },
    },
  },
}
