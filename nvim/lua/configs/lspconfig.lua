local lspconfig = require("lspconfig")
local map = vim.keymap.set

local baseConfig = require("nvchad.configs.lspconfig")
baseConfig.defaults()

local LSP_SERVERS = {
    rust_analyzer = {},
    clangd = {},

    stylua = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                        vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                        "${3rd}/luv/library",
                    },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },

    jsonls = {
        schemas = nil, -- set in config function
        validate = { enable = true },
    },

    marksman = {},
}

local LSP_KEYMAPS = {
    -- stylua: ignore start
    { 'K',
        function() vim.lsp.buf.hover() end,
        desc = "Toggle Hover window" },
    { 'G',
        function() vim.diagnostic.open_float() end,
        desc = "Open Diagnostic float window" },
    { '<C-r>',
        function() vim.lsp.buf.rename() end,
        desc = "Rename symbol" },
    { '[d',
        function() vim.diagnostic.jump({ count = 1, float = true }) end,
        desc = "Jump to previous diagnostic" },
    { ']d',
        function() vim.diagnostic.jump({ count = -1, float = true }) end,
        desc = "Jump to next diagnostic" },
    { '<leader>a',
        function() vim.lsp.buf.code_action() end,
        desc = "Code actions" },
    { '<C-f>',
        function () require("conform").format { lsp_fallback = true } end,
        desc = "Format document",
        mode = { 'n', 'x' } },
    { '<C-r>',
        require("nvchad.lsp.renamer"),
        desc = "NvRenamer" },
    -- stylua: ignore end
}

dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        for _, keymap in ipairs(LSP_KEYMAPS) do
            map(keymap.mode or "n", keymap[1], keymap[2], { buffer = args.buf, desc = "LSP " .. keymap.desc })
        end
    end,
})

vim.lsp.config("*", { capabilities = baseConfig.capabilities, on_init = baseConfig.on_init })

for lsp, config in pairs(LSP_SERVERS) do
    lspconfig[lsp].setup(vim.tbl_extend("keep", {
        capabilities = baseConfig.capabilities,
        on_init = baseConfig.on_init,
    }, config))
end
