return {
  "luukvbaal/statuscol.nvim",
  config = function()
    -- Custom function to show both absolute and relative line numbers
    local function lnum_both(args)
      return string.format("%3d %2d", args.lnum, args.relnum)
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
