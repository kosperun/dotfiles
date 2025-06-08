-- NOTE: THIS IS A VERSION FROM https://github.com/jellydn/cspell-tool
-- here's the video with demo (in Vietnameze though): https://www.youtube.com/watch?v=3IwMd77_P8E
-- It uses three packages: codespell, misspell and cspell. misspell is archived, so I decided not use the upstream plugin
-- below instead of this. DECIDE ON WHICH IS BETTER!
--
-- local key_mapping = "<leader>cn"
-- -- Example config with lazyvim
-- return {
--   -- Set up null-ls to check spelling
--   {
--     "nvimtools/none-ls.nvim",
--     keys = {
--       { key_mapping, "<cmd>NullLsInfo<cr>", desc = "NullLs Info" },
--     },
--     dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
--     event = { "BufReadPre", "BufNewFile" },
--     opts = function()
--       local cspell = require("cspell")
--       local ok, none_ls = pcall(require, "null-ls")
--       if not ok then
--         return
--       end
--
--       local b = none_ls.builtins
--
--       local sources = {
--         -- spell check
--         b.diagnostics.codespell,
--         -- b.diagnostics.misspell,
--         -- cspell
--         cspell.diagnostics.with({
--           -- Set the severity to HINT for unknown words
--           diagnostics_postprocess = function(diagnostic)
--             diagnostic.severity = vim.diagnostic.severity["HINT"]
--           end,
--         }),
--         cspell.code_actions,
--       }
--       -- Define the debounce value
--       local debounce_value = 200
--       return {
--         sources = sources,
--         debounce = debounce_value,
--         debug = true,
--       }
--     end,
--   },
-- }
-- Note: In order for this to work you need to install cspell and create a config json file (https://cspell.org/docs/getting-started):
return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local cspell = require("cspell")

      opts.sources = opts.sources or {}

      table.insert(
        opts.sources,
        cspell.diagnostics.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        })
      )
      table.insert(opts.sources, cspell.code_actions)
    end,
  },
}
