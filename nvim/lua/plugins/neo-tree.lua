return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  -- This is taken from folke's Snacks.nvim example how to integrate Snacks.rename into neo-tree, but it's not working.
  opts = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
  end,
  -- opts = {
  --   filesystem = {
  --     filtered_items = {
  --       hide_dotfiles = false,
  --       always_show = { -- remains visible even if other settings would normally hide it
  --         ".env",
  --         "backend.env",
  --       },
  --       hide_by_name = {
  --         ".vscode",
  --         ".git",
  --       },
  --     },
  --   },
  window = {
    mappings = {
      ["Y"] = function(state)
        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        -- Calculate the relative path for Python imports
        local cwd = vim.fn.getcwd()
        local relative_path = modify(filepath, ":.") -- Relative path (CWD)
        local python_import_path = relative_path:gsub(cwd .. "/", ""):gsub("/", "."):gsub("%.py$", "")

        local results = {
          python_import_path, -- 1: Python import path
          modify(filepath, ":."), -- 2: Relative path (CWD)
          filename, -- 3: Filename
          modify(filename, ":r"), -- 4: Filename without extension
          filepath, -- 5: Absolute path
          modify(filepath, ":~"), -- 6: Relative path (HOME)
        }

        vim.ui.select({
          "1. Python import path: " .. results[1],
          "2. Relative path (CWD): " .. results[2],
          "3. Filename: " .. results[3],
          "4. Filename without extension: " .. results[4],
          "5. Absolute path: " .. results[5],
          "6. Relative path (HOME): " .. results[6],
        }, { prompt = "Choose to copy to clipboard:" }, function(choice)
          if choice then
            local i = tonumber(choice:sub(1, 1))
            if i then
              local result = results[i]
              vim.fn.setreg("+", result)
              vim.notify("Copied: " .. result)
            else
              vim.notify("Invalid selection")
            end
          else
            vim.notify("Selection cancelled")
          end
        end)
      end,
      description = "Copy paths to clipboard",
    },
  },
}
