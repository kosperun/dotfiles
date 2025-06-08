vim.filetype.add({
  pattern = {
    ["%.env$"] = "dotenv", -- Or "text" if you prefer it to be treated as plain text
    [".*%.env%.example$"] = "dotenv", -- Or "text" if you prefer it to be treated as plain text
  },
})
