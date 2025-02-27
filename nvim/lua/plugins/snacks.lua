return {
    {
        "folke/snacks.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },

        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
            { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep" },
            { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
            { "<leader>n",       function() Snacks.picker.notifications() end,         desc = "Notification History" },
            { "<leader>e",           function() Snacks.explorer() end,                     desc = "File Explorer" },

            -- find

            { "<leader>ff",      function() Snacks.picker.files() end,                 desc = "Find Files" },
            -- search
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
            -- LSP
            { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "gr",              function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
            { "gI",              function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gy",              function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
            { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            -- Other
            { "<leader>cR",      function() Snacks.rename.rename_file() end,           desc = "Rename File" },
            { "<leader>l",      function() Snacks.lazygit() end,                      desc = "Lazygit" },
        },

        init = function()
            vim.api.nvim_create_autocmd('QuitPre', {
                callback = function()
                    local snacks_windows = {}
                    local floating_windows = {}
                    local windows = vim.api.nvim_list_wins()
                    for _, w in ipairs(windows) do
                        local filetype = vim.api.nvim_get_option_value('filetype', { buf = vim.api.nvim_win_get_buf(w) })
                        if filetype:match('snacks_') ~= nil then
                            table.insert(snacks_windows, w)
                        elseif vim.api.nvim_win_get_config(w).relative ~= '' then
                            table.insert(floating_windows, w)
                        end
                    end
                    if 1 == #windows - #floating_windows - #snacks_windows then
                        -- Should quit, so we close all Snacks windows.
                        for _, w in ipairs(snacks_windows) do
                            vim.api.nvim_win_close(w, true)
                        end
                    end
                end,
            })
        end
    }
}
