vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- SYNTAX --

vim.cmd.syntax("enable")
vim.cmd.syntax("on")

-- INDENTS

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showmatch = true
vim.opt.smarttab = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- mouse
vim.opt.mouse = ""

-- Set 2 spaces for yaml
vim.api.nvim_create_autocmd("FileType", {
    pattern = { 
        "*.yaml", "*.yml" 
    },
    callback = function ()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end
})

-- Theme
vim.cmd.colorscheme("gruvbox")

