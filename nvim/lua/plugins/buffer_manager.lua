return {
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>,", '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<CR>', desc = "Buffer Manager" },
  },
  opt = {
    select_menu_item_commands = {
      v = {
        key = "<C-v>",
        command = "vsplit",
      },
      h = {
        key = "<C-h>",
        command = "split",
      },
    },
    order_buffers = "lastused",
    highlight = "Normal:BufferManagerBorder",
    short_file_names = true,
  },
}
