return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["Y"] = function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            modify(filepath, ":."), -- 1: Relative path (CWD)
            filename, -- 2: Filename
            modify(filename, ":r"), -- 3: Filename without extension
            filepath, -- 4: Absolute path
            modify(filepath, ":~"), -- 5: Relative path (HOME)
          }

          vim.ui.select({
            "1. Relative path (CWD): " .. results[1],
            "2. Filename: " .. results[2],
            "3. Filename without extension: " .. results[3],
            "4. Absolute path: " .. results[4],
            "5. Relative path (HOME): " .. results[5],
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
      },
    },
  },
}
