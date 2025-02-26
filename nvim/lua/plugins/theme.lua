return {
    {
        "morhetz/gruvbox",
        lazy = false,
        config = function()
            vim.cmd.colorscheme("gruvbox")

            vim.cmd([[highlight! link SignColumn Normal]])
        end
    }
}
