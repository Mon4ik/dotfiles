return {
    { "folke/which-key.nvim", enabled = false },

    {
        "stevearc/conform.nvim",
        opts = require("configs.conform"),
    },

    {
        "neovim/nvim-lspconfig",
        opts = require("configs.lspconfig"),
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "lsp")
            require("nvchad.lsp").diagnostic_config()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    for _, keymap in ipairs(opts.keymaps) do
                        vim.keymap.set(
                            keymap.mode or "n",
                            keymap[1],
                            keymap[2],
                            { buffer = args.buf, desc = "LSP " .. keymap.desc }
                        )
                    end
                end,
            })

            local baseConfig = require("nvchad.configs.lspconfig")
            vim.lsp.config("*", { capabilities = baseConfig.capabilities, on_init = baseConfig.on_init })

            local lspconfig = require("lspconfig")
            for lsp, config in pairs(opts.servers) do
                lspconfig[lsp].setup(vim.tbl_extend("keep", {
                    capabilities = baseConfig.capabilities,
                    on_init = baseConfig.on_init,
                }, config))
            end
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
