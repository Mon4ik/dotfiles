local lspconfig = require("lspconfig")

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

for lsp, config in pairs(LSP_SERVERS) do
    lspconfig[lsp].setup(vim.tbl_extend("keep", {
        capabilities = baseConfig.capabilities,
        on_init = baseConfig.on_init,
    }, config))
end
