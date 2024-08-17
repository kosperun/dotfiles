return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Keymaps for telescope extensions
      -- I overrode sd -> sx because it's closer to x in which-key diagnostics group
      { "<leader>sD", false },
      { "<leader>sx", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sX", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      -- I overrode sa -> sA because I don't use it often
      { "<leader>sA", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sa", "<cmd>Telescope live_grep_args<CR>", desc = "Grep with args", { noremap = true, silent = true } },
      {
        "<leader>sd",
        "<cmd>Telescope dir live_grep<CR>",
        { noremap = true, silent = true },
        desc = "Search text in directory",
      },
      {
        "<leader>fd",
        "<cmd>Telescope dir find_files<CR>",
        { noremap = true, silent = true },
        desc = "Find files in directory",
      },
      {
        "<leader>y",
        "<cmd>lua require('search').open()<CR>",
        "Search with tabs",
        desc = "Telescope pickers as tabs",
      },
    },
    opts = {
      defaults = {
        cache_picker = {
          -- we need to have a picker history we can work with
          num_pickers = 100,
        },
      },
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--trim",
      "--multiline",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local send_find_files_to_live_grep = function()
        local files = {}
        local prompt_bufnr = vim.api.nvim_get_current_buf()
        require("telescope.actions.utils").map_entries(prompt_bufnr, function(entry, _, _)
          table.insert(files, entry[0] or entry[1])
        end)
        require("telescope.builtin").live_grep({
          search_dirs = files,
        })
      end

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-,>"] = function()
                require("telescope-picker-history-action").prev_picker()
              end,
              ["<C-.>"] = function()
                require("telescope-picker-history-action").next_picker()
              end,
              ["<C-Up>"] = actions.cycle_history_next,
              ["<C-Down>"] = actions.cycle_history_prev,
              ["<c-e>"] = actions.to_fuzzy_refine,
              -- {
              --   "<C-i>",
              --   function()
              --     vim.g.telescope_ignore_enabled = not vim.g.telescope_ignore_enabled
              --     local telescope_ignore_patterns = {
              --       "creative/.*",
              --     }
              --     require("telescope.config").set_defaults({
              --       file_ignore_patterns = vim.g.telescope_ignore_enabled and telescope_ignore_patterns or {},
              --     })
              --   end,
              --   desc = "Toggle telescope ignore patterns",
              --   { noremap = true, silent = true },
              -- },
            },
          },
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          file_ignore_patterns = { "creative/", ".*package%-lock%.json" },
          winblend = 0,
          history = {
            path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
            limit = 100,
          },
        },
        pickers = {
          -- Your special builtin config goes in here
          buffers = {
            initial_mode = "normal",
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          find_files = {
            mappings = {
              n = {
                ["<c-f>"] = send_find_files_to_live_grep,
              },
              i = {
                ["<c-f>"] = send_find_files_to_live_grep,
              },
            },
          },
        },
      })
    end,
  },
}
