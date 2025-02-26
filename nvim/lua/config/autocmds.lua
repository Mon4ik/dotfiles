vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "*.yaml", "*.yml",
        "*.sql"
    },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end
})
