return {
  "FabianWirth/search.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    local extensions = require("telescope").extensions
    require("search").setup({
      tabs = {
        {
          "Files",
          builtin.find_files,
        },
        {
          "Live Grep Args",
          function()
            extensions.live_grep_args.live_grep_args()
          end,
        },
        {
          "Current Buffer Fuzzy Find",
          builtin.current_buffer_fuzzy_find,
        },
        -- {
        --   "Buffers",
        --   builtin.buffers,
        -- },
        {
          "Command History",
          builtin.command_history,
        },
        {
          "Search History",
          builtin.search_history,
        },
        {
          "Recent Files",
          builtin.oldfiles,
        },
        -- {
        --   "Keymaps",
        --   builtin.keymaps,
        -- },
        {
          "Jumplist",
          builtin.jumplist,
        },
        {
          "QuickFix",
          builtin.quickfix,
          available = function()
            return not vim.tbl_isempty(vim.fn.getqflist())
          end,
        },
      },
    })
  end,
}
