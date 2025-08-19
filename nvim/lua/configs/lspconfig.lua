return {
    servers = {
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
    },

    keymaps = {
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
    },
}
