---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "gruvbox",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.nvdash = { load_on_startup = true }
M.ui = {
    statusline = {
        theme = "minimal",
        order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "cursor" },
    },
}

return M
