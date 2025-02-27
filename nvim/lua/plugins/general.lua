return {
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
