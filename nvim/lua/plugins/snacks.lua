-- local word_grep_exact = false
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>j",
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["dd"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
        })
      end,
      desc = "Buffers (CUSTOM)",
    },
    --   {
    --     "<leader>sw",
    --     function()
    --       word_grep_exact = not word_grep_exact
    --       Snacks.picker.grep_word({ args = { "-w" } })
    --     end,
    --     desc = "Visual selection or word (cwd, exact match -w)",
    --     mode = { "n", "x" },
    --   },
    --   {
    --     "<leader>sW",
    --     function()
    --       word_grep_exact = not word_grep_exact
    --       Snacks.picker.grep_word()
    --     end,
    --     desc = "Visual selection or word (cwd, default (fuzzy) match)",
    --     mode = { "n", "x" },
    --   },
  },
  ---@type snacks.Config
  opts = {
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    picker = {
      matcher = { frecency = true, history_bonus = true },
      formatters = {
        file = {
          -- whatever sane or insane value you need, default was 40
          truncate = 300,
        },
      },
      actions = {
        -- Suggested by nyxed https://github.com/LazyVim/LazyVim/discussions/6148#discussioncomment-13474853
        word_grep = function(p)
          local opts = p.opts
          opts.args = opts.args or {}

          if vim.tbl_contains(opts.args, "-w") then
            opts.args = vim.tbl_filter(function(arg)
              return arg ~= "-w"
            end, opts.args)
          else
            table.insert(opts.args, "-w")
          end
          p:find()
        end,
        -- suggested by dpetka https://github.com/LazyVim/LazyVim/discussions/6148#discussioncomment-13475388
        toggle_regex = function(picker)
          picker.opts.regex = not picker.opts.regex
          picker:find()
        end,
        -- Add toggle_ignorecase action
        toggle_ignorecase = function(picker)
          vim.notify("DEBUG: toggle_ignorecase called from line: " .. debug.getinfo(1).currentline, vim.log.levels.INFO)

          picker.opts.matcher = picker.opts.matcher or {}

          local current_ignorecase = picker.opts.matcher.ignorecase
          vim.notify("DEBUG: Current ignorecase: " .. tostring(current_ignorecase), vim.log.levels.INFO)

          picker.opts.matcher.ignorecase = not current_ignorecase
          vim.notify("DEBUG: New ignorecase: " .. tostring(picker.opts.matcher.ignorecase), vim.log.levels.INFO)

          local current_query = picker.input.text or ""
          vim.notify("DEBUG: Query string before aggressive refresh: '" .. current_query .. "'", vim.log.levels.INFO)

          -- *** THE NEW AGGRESSIVE REFRESH ***
          -- 1. Temporarily clear the input to force a full matcher reset (if it responds to empty query)
          picker:find("")
          -- 2. Immediately re-set the input with the original query, which should then apply the new ignorecase setting
          picker:find(current_query)
        end,
      },
      win = {
        input = {
          keys = {
            ["<c-z>"] = { "word_grep", mode = { "n", "i" } },
            ["<a-r>"] = { "toggle_regex", mode = { "n", "i" }, desc = "Toggle Regex" },
            ["<a-i>"] = { "toggle_ignorecase", mode = { "n", "i" }, desc = "Toggle Ignore Case" },
          },
        },
      },
    },
  },
}
