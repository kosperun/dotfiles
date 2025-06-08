-- return {
--   "luukvbaal/statuscol.nvim",
--   opts = function()
--     local builtin = require("statuscol.builtin")
--     return {
--       setopt = true,
--       -- override the default list of segments with:
--       -- number-less fold indicator, then signs, then line number & separator
--       segments = {
--         { text = { "%s" }, click = "v:lua.ScSa" },
--         { text = { "%s" }, click = "v:lua.ScSa" },
--         {
--           text = { builtin.lnumfunc, " " },
--           condition = { true, builtin.not_empty },
--           click = "v:lua.ScLa",
--         },
--       },
--     }
--   end,
-- }
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    -- Custom function to show both absolute and relative line numbers
    local function lnum_both()
      local lnum = vim.v.lnum
      local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
      return string.format("%3d %2d", lnum, relnum)
    end
    require("statuscol").setup({
      setopt = true,
      segments = {
        -- Git signs first
        {
          sign = {
            namespace = { "gitsigns.*" }, -- only Git signs
            name = { "gitsigns.*" }, -- only Git signs
          },
        },
        -- Diagnostics second
        {
          sign = {
            namespace = { ".*" },
            name = { ".*" },
            -- maxwidth = 2,
            auto = true,
          },
        },
        -- Line number last
        {
          text = { lnum_both, " " },
          condition = { true },
          click = "v:lua.ScLa",
        },
      },
    })
  end,
}
