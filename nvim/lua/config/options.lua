-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local constants = require("config.constants")

-- Make hidden and ignored files lighter
vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#928374" })
vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { fg = "#928374" })

vim.g.python3_host_prog = "~/venvs/.nvim-venv/bin/python"
vim.g.python_host_prog = "~/.venvs/.nvim-venv/bin/python"
vim.g.wordmotion_prefix = "\\"

vim.o.autoread = true
vim.o.colorcolumn = tostring(constants.max_line_length)
vim.o.conceallevel = 1
vim.o.foldmethod = "manual"
vim.o.foldtext = "v:lua.require'config.folds'.custom_fold_text()"
-- vim.o.langmap =
--   [[йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\;,є',ґ\\,яz,чx,сc,мv,иb,тn,ьm,ю.,./,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\:,Є\",Ґ|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,№#,ж;,Ж:,б,,ю.,./,‚?,ʼ~,\'`,\\;$,\\:^]]
--
vim.o.langmap =
  [[йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\;,є',ґ\\,яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\:,Є\",Ґ|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,№#,ʼ~,\'\`]]
