vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- @see init.lua
-- vim.g.mapleader = ","

----[[ SYNTAX ]]----
vim.cmd.syntax("enable")
vim.cmd.syntax("on")

vim.opt.list = true
vim.opt.listchars = "space:·"

----[[ SIDE COLUMNS (with diagnostics/numbers) ]]----

vim.opt.number = true
vim.opt.signcolumn = "yes"

----[[ INDENTS ]]----
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showmatch = true
vim.opt.smarttab = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

----[[ MOUSE ]]----
vim.opt.mouse = ""

vim.opt.backup = false
vim.opt.writebackup = false

----[[ OTHER ]]----
-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"
