return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        lazy = false,
        opts = {
            servers = {
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
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            telemetry = {
                                enable = false,
                            },
                        }
                    }
                },
                rust_analyzer = {}
            },
            icons = {
                [vim.diagnostic.severity.ERROR] = '',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.HINT] = '󰌵',
                [vim.diagnostic.severity.INFO] = '',
            }
        },
        config = function(_, opts)
            local ensure_installed = {}
            for k, _ in pairs(opts.servers) do
                ensure_installed[#ensure_installed + 1] = k
            end

            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
            }

            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            for lsp, config in pairs(opts.servers) do
                lspconfig[lsp].setup(
                    vim.tbl_extend(
                        "force",
                        { capabilities = capabilities },
                        config
                    )
                )
            end

            vim.diagnostic.config({
                signs = {
                    text = opts.icons,
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                        [vim.diagnostic.severity.HINT] = 'HintMsg',
                    },
                },
                virtual_text = {
                    spacing = 8,
                    prefix = function(diagnostic)
                        return opts.icons[diagnostic.severity]
                    end,
                },
                update_in_insert = true,
                float = {
                    border = "rounded",
                    format = function(d)
                        return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
                    end,
                },
                underline = true,
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local keymap_opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', keymap_opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', keymap_opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', keymap_opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', keymap_opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', keymap_opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', keymap_opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', keymap_opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', keymap_opts)

                    vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
                    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

                    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', keymap_opts)
                    vim.keymap.set({ 'n', 'x' }, '<C-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                        keymap_opts)
                end,
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        lazy = false,
        dependencies = {
            "L3MON4D3/LuaSnip",

            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }
                }, {
                    { name = 'buffer' },
                })
            })

            -- Add `:Format` command to format current buffer
            vim.api.nvim_create_user_command("Format", function()
                vim.lsp.buf.format()
            end, {})

            -- " Add `:Fold` command to fold current buffer
            vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

            -- Add `:OR` command for organize imports of the current buffer
            vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
                {})
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline({ '/', '?' }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --         { name = 'buffer' }
            --     }
            -- })

            -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline(':', {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({
            --         { name = 'path' }
            --     }, {
            --         { name = 'cmdline' }
            --     }),
            --     matching = { disallow_symbol_nonprefix_matching = false }
            -- })
        end,
    }
}
