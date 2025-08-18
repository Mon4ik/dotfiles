require("nvchad.autocmds")

-- open nvim-tree on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        require("nvim-tree.api").tree.open()
    end,
})
