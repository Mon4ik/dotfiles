---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "gruvbox",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.nvdash = {
    load_on_startup = true,
    buttons = {
        { txt = "•  Dotfiles", keys = "df", cmd = "cd ~/.dotfiles/" },
        { txt = "  Touch grass", keys = "q", cmd = "qa" },
        {
            txt = function()
                local stats = require("lazy").stats()

                return string.format("  Loaded %d/%d plugins in %d ms", stats.loaded, stats.count, stats.startuptime)
            end,
            hl = "NvDashFooter",
            no_gap = true,
        },
    },
}

M.ui = {
    statusline = {
        theme = "minimal",
        order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "cursor" },
    },
}

return M
