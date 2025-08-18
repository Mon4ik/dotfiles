return {
    {
        "stevearc/conform.nvim",
        opts = require("configs.conform"),
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
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
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "onsails/lspkind.nvim",
        },
        opts = function()
            return require("configs.nvim-cmp")
        end,
    },
}
