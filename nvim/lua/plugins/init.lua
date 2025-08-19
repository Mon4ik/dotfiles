return {
    { "folke/which-key.nvim", enabled = false },

    {
        "stevearc/conform.nvim",
        opts = require("configs.conform"),
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = require("configs.nvim-tree"),
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require("configs.gitsigns")
        end,
    },
}
