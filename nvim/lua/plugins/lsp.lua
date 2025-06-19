return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neoconf.nvim",
            "lopi-py/luau-lsp.nvim"
        },
        priority = 1000,
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
                                globals = { "vim", "Snacks" },
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
                rust_analyzer = {},
                clangd = {
                },

                svelte = {},
                ts_ls = {},
                cssls = {},
                tailwindcss = {},

                stylua = {},

                jsonls = {},
                -- protols = {},

                docker_compose_language_service = {},
                dockerls = {},
                marksman = {},
            },
            neoconf = {},
            icons = {
                [vim.diagnostic.severity.ERROR] = '',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.HINT] = '󰌵',
                [vim.diagnostic.severity.INFO] = '',
            }
        },
        keys = {
            { 'K',         function() vim.lsp.buf.hover() end,         desc = "Toggle Hover window" },
            { 'G',         function() vim.diagnostic.open_float() end, desc = "Open Diagnostic float window" },
            { '<C-r>',     function() vim.lsp.buf.rename() end,        desc = "Rename symbol" },
            { '[d',        function() vim.diagnostic.goto_prev() end,  desc = "Jump to previous diagnostic" },
            { ']d',        function() vim.diagnostic.goto_next() end,  desc = "Jump to next diagnostic" },
            { '<leader>a', function() vim.lsp.buf.code_action() end,   desc = "Code actions" },
            { '<C-f>',     ":Format<CR>",                              desc = "Format document",             mode = { 'n', 'x' } }
        },
        config = function(_, opts)
            local ensure_installed = {}
            for k, _ in pairs(opts.servers) do
                ensure_installed[#ensure_installed + 1] = k
            end

            require("neoconf").setup(opts.neoconf)

            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
            }

            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            for lsp, config in pairs(opts.servers) do
                lspconfig[lsp].setup(
                    vim.tbl_extend(
                        "keep",
                        {
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                                if client.server_capabilities.document_formatting then
                                    vim.keymap.set({ "v", "n" }, "<C-f>", function()
                                        vim.lsp.buf.format({})
                                    end, bufopts)
                                else
                                    vim.keymap.set("n", "<C-f>", ":Format<cr>", bufopts)
                                end
                            end
                        },
                        config
                    )
                )
            end

            require("luau-lsp").setup({
                platform = {
                    type = "roblox",
                },
                types = {
                    roblox_security_level = "PluginSecurity",
                },
                sourcemap = {
                    enabled = true,
                    autogenerate = false, -- automatic generation when the server is attached
                    rojo_project_file = "default.project.json",
                    sourcemap_file = "sourcemap.json",
                },
                plugin = {
                    enabled = true,
                    port = 3667,
                },
                fflags = {
                    -- enable_new_solver = true, -- enables the flags required for luau's new type solver
                    sync = true,               -- sync currently enabled fflags with roblox's published fflags
                    override = {               -- override fflags passed to luau
                        LuauTableTypeMaximumStringifierLength = "0",
                    },
                },
                server = {
                    capabilities = capabilities,
                    settings = {
                        ["luau-lsp"] = {
                            require = {
                                directoryAliases = {
                                    ["@pkg/"] = "./Packages/",
                                    ["@dev-pkg/"] = "./DevPackages/",
                                    ["@root/"] = "./src/",
                                    ["@client/"] = "./src/client/",
                                    ["@server/"] = "./src/server/",
                                    ["@shared/"] = "./src/shared/"
                                }
                            }
                        }
                    }
                },
            })

            vim.diagnostic.config({
                signs = {
                    text = opts.icons,
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                        [vim.diagnostic.severity.HINT] = 'HintMsg',
                        [vim.diagnostic.severity.INFO] = 'InfoMsg',
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
            "hrsh7th/cmp-nvim-lsp-signature-help",

            "onsails/lspkind.nvim"
        },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = {
                            menu = 50,
                            abbr = 50,
                        },
                        ellipsis_char = '...',
                        show_labelDetails = true,
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    }),
                },
                performance = {
                    max_view_entries = 32,
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = "rounded",
                        winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None"
                    },
                    documentation = vim.tbl_extend(
                        'force',
                        cmp.config.window.bordered(),
                        {
                            winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None"
                        }
                    )
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
                    { name = "nvim_lsp_signature_help" },
                })
            })

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
