require "nvchad.options"

local opt = vim.opt
local o = vim.o
local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.list = true
opt.listchars = "space:·"

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
