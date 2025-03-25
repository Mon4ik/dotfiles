return {
    {
        "folke/snacks.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },

        ---@type snacks.Config
        opts = {
            dashboard = {
                enabled = true,

                width = 60,
                row = nil,    -- dashboard position. nil for center
                col = nil,    -- dashboard position. nil for center
                pane_gap = 4, -- empty columns between vertical panes
                autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
                preset = {
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = "󰔶 ", key = "M", desc = "Mason", action = ":Mason" },

                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    header = ([[
`7MN.   `7MF'              `7MMF'   `7MF'db                    $
  MMN.    M                  `MA     ,V  ``                    $
  M YMb   M  .gP"Ya   ,pW"Wq. VM:   ,V `7MM  `7MMpMMMb.pMMMb.  $
  M  `MN. M ,M'   Yb 6W'   `Wb MM.  M'   MM    MM    MM    MM  $
  M   `MM.M 8M"""""" 8M     M8 `MM A'    MM    MM    MM    MM  $
  M     YMM YM.    , YA.   ,A9  :MM;     MM    MM    MM    MM  $
.JML.    YM  `Mbmmd'  `Ybmd9'    VF    .JMML..JMML  JMML  JMML.$

The Editor. Not a Web Slop.]]):gsub('%$', ''),
                },
                formats = {
                    icon = function(item)
                        if item.file and item.icon == "file" or item.icon == "directory" then
                            local icon, hl = Snacks.util.icon(item.file, item.icon)
                            return { icon, width = 2, hl = hl }
                        end
                        return { item.icon, width = 2, hl = "icon" }
                    end,
                    footer = { "%s", align = "center" },
                    header = { "%s", align = "center" },
                    key = function(item)
                        return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
                    end,
                    file = function(item, ctx)
                        local fname = vim.fn.fnamemodify(item.file, ":~")
                        fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                        if #fname > ctx.width then
                            local dir = vim.fn.fnamemodify(fname, ":h")
                            local file = vim.fn.fnamemodify(fname, ":t")
                            if dir and file then
                                file = file:sub(-(ctx.width - #dir - 2))
                                fname = dir .. "/…" .. file
                            end
                        end
                        local dir, file = fname:match("^(.*)/(.+)$")
                        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or
                            { { fname, hl = "file" } }
                    end,
                },
                sections = {
                    { section = "header" },
                    { icon = "󰊕 ", title = "Actions", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Folders", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            },
            indent = { enabled = true },
            scope = { enabled = true },

            bigfile = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },

            picker = { enabled = true },
            input = { enabled = true },
            explorer = { enabled = true },

            notifier = {
                enabled = true,
                timeout = 3000,
            },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
            { "<leader>/",       function() Snacks.picker.grep() end,                  desc = "Grep" },
            { "<leader>:",       function() Snacks.picker.command_history() end,       desc = "Command History" },
            { "<leader>n",       function() Snacks.picker.notifications() end,         desc = "Notification History" },
            { "<leader>e",       function() Snacks.explorer() end,                     desc = "File Explorer" },

            -- Find/Search
            { "<leader>ff",      function() Snacks.picker.files() end,                 desc = "Find Files" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },

            -- LSP
            { "gd",              function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gD",              function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "gr",              function() Snacks.picker.lsp_references() end,        desc = "References",           nowait = true },
            { "gI",              function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gt",              function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto Type Definition" },
            { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

            -- Other
            { "<leader>r",       function() Snacks.rename.rename_file() end,           desc = "Rename File" },
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
                        for _, w in ipairs(snacks_windows) do
                            vim.api.nvim_win_close(w, true)
                        end
                    end
                end,
            })
        end
    }
}
