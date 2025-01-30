return {
    -- {
    --     "williamboman/mason.nvim",
    --     lazt = false,

    --     dependencies = {
    --         "williamboman/mason-lspconfig.nvim",
    --         "neovim/nvim-lspconfig"
    --     },

    --     config = function()
    --         require("mason").setup()
    --         require("mason-lspconfig").setup()

    --         require("lspconfig").clangd.setup {
    --         }
    --         require("lspconfig").rust_analyzer.setup {
    --         }
    --         require("lspconfig").lua_ls.setup {
    --             settings = {
    --                 Lua = {
    --                     runtime = {
    --                         version = "LuaJIT",
    --                     },
    --                     diagnostics = {
    --                         globals = { "vim" },
    --                     },
    --                     workspace = {
    --                         library = vim.api.nvim_get_runtime_file("", true),
    --                     },
    --                     telemetry = {
    --                         enable = false,
    --                     },
    --                 }
    --             }
    --         }
    --     end
    -- },
    {
        "neoclide/coc.nvim",
        branch = "release",
    }
}
