require("nvchad.autocmds")

-- open nvim-tree on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
            return
        end

        -- change to the directory
        vim.cmd.cd(data.file)

        -- open the tree
        require("nvim-tree.api").tree.open()
    end,
})
