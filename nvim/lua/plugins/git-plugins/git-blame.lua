return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  opts = {
    -- your configuration comes here
    date_format = "%Y-%b-%d %H:%M:%S %a (%r)",
  },
  keys = {
    { "<leader>gt", "<cmd>GitBlameToggle<cr>", desc = "Git Blame Toggle CUSTOM" },
  },
  config = function(_, opts)
    require("gitblame").setup(opts)

    -- Work repos use a "github.com-<alias>" SSH host alias to pick the
    -- right key. That alias isn't a real domain, so strip it back to
    -- github.com before opening a browser URL.
    local utils = require("gitblame.utils")
    local original_launch_url = utils.launch_url
    utils.launch_url = function(url)
      original_launch_url((url:gsub("github%.com%-%w+", "github.com")))
    end
  end,
}
