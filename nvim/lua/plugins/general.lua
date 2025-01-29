return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require('lualine').setup {
                options = { theme = "gruvbox" },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'diagnostics' },
                    lualine_y = { 'filetype' },
                    lualine_z = { 'location' }
                }
            }
        end
    },
    {
        "normen/vim-pio",
        lazy = false
    }
}
