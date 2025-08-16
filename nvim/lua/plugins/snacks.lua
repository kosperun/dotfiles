-- local word_grep_exact = false
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
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
        toggle_sort_by_path = function(p)
          local opts = p.opts
          opts.args = opts.args or {}

          -- Find the index of '--' if it exists
          local dashdash_index = nil
          for i, arg in ipairs(opts.args) do
            if arg == "--" then
              dashdash_index = i
              break
            end
          end

          -- Check if '--sort path' already present
          local has_sort = false
          for i = 1, #opts.args - 1 do
            if opts.args[i] == "--sort" and opts.args[i + 1] == "path" then
              has_sort = true
              -- remove it
              table.remove(opts.args, i + 1)
              table.remove(opts.args, i)
              break
            end
          end

          -- Insert if not present
          if not has_sort then
            if dashdash_index then
              table.insert(opts.args, dashdash_index, "--sort")
              table.insert(opts.args, dashdash_index + 1, "path")
            else
              table.insert(opts.args, "--sort")
              table.insert(opts.args, "path")
            end
          end

          p:find()
        end,
        -- Suggested by nyxed https://github.com/LazyVim/LazyVim/discussions/6148#discussioncomment-13474853
        word_grep_exact = function(p)
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
            ["<c-z>"] = { "word_grep_exact", mode = { "n", "i" } },
            ["<a-o>"] = { "toggle_sort_by_path", mode = { "n", "i" } },
            ["<a-r>"] = { "toggle_regex", mode = { "n", "i" }, desc = "Toggle Regex" },
            ["<a-i>"] = { "toggle_ignorecase", mode = { "n", "i" }, desc = "Toggle Ignore Case" },
          },
        },
      },
    },
  },
}
