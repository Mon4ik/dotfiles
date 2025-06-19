vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "*.yaml", "*.yml",
        "*.sql", "*.css", "*.scss"
    },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end
})
