return {
    {
        "mg979/vim-visual-multi",
        config = function()
        end
    },
    -- TODO: add proper debugging
    -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                sign_priority = 10,
            })
        end
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "neovim/nvim-lspconfig",
        },
        opts = {}
    },
    {
        "mhartington/formatter.nvim",
        name = "formatter",
        version = "*",
        config = function()
            local util = require("formatter.util")

            require("formatter").setup({
                -- Enable or disable logging
                logging = true,
                -- Set the log level
                log_level = vim.log.levels.WARN,
                -- All formatter configurations are opt-in
                filetype = {
                    -- Formatter configurations for filetype "lua" go here
                    -- and will be executed in order
                    luau = {
                        -- "formatter.filetypes.lua" defines default configurations for the
                        -- "lua" filetype
                        require("formatter.filetypes.lua").stylua,

                        -- You can also define your own configuration
                        function()
                            -- Supports conditional formatting
                            if util.get_current_buffer_file_name() == "special.lua" then
                                return nil
                            end

                            -- Full specification of configurations is down below and in Vim help
                            -- files
                            return {
                                exe = "stylua",
                                args = {
                                    "--search-parent-directories",
                                    "--stdin-filepath",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                    "--",
                                    "-",
                                },
                                stdin = true,
                            }
                        end
                    },

                    -- Use the special "*" filetype for defining formatter configurations on
                    -- any filetype
                    ["*"] = {
                        function()
                            local formatters = require("formatter.util").get_available_formatters_for_ft(vim.bo.filetype)
                            if #formatters > 0 then
                                return
                            end
                            -- check if there are any LSP formatters
                            local lsp_clients = vim.lsp.get_clients()
                            for _, client in pairs(lsp_clients) do
                                if client.server_capabilities.documentFormattingProvider then
                                    vim.lsp.buf.format()
                                    return
                                end
                            end
                        end
                    }
                }
            })
        end
    }
}
