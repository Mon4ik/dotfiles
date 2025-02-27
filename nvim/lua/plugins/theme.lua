return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("gruvbox").setup {}

            vim.opt.background = "dark"
            vim.cmd.colorscheme("gruvbox")

            vim.cmd([[highlight! link SignColumn Normal]])
            vim.cmd([[highlight! link ColorColumn Normal]])
            vim.cmd([[highlight! link SnacksPicker Normal]])
            vim.cmd([[highlight! link SnacksPickerBorder Normal]])
            vim.cmd([[highlight! link SnacksPickerGitStatusUntracked Text]])
        end
    }
}
