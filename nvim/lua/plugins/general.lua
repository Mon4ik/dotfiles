return {
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            filters = {
                enable = true,
                git_ignored = false,
                dotfiles = false,
                custom = { "^.git$" }
            },
            renderer = {
                group_empty = true,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },
                icons = {
                    glyphs = {
                        default = "",
                        symlink = "",
                        bookmark = "󰆤",
                        modified = "●",
                        hidden = "󰜌",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "M",
                            staged = "S",
                            unmerged = "",
                            renamed = "R",
                            untracked = "?",
                            deleted = "R",
                            ignored = "-",
                        },
                    },
                }
            }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
        config = function()
            local builtin = require('telescope.builtin')

            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require('lualine').setup {
                options = { theme = "gruvbox" },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'diagnostics' },
                    lualine_y = { 'filetype' },
                    lualine_z = { 'location' }
                }
            }
        end
    },
    {
        "normen/vim-pio",
        lazy = false
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local highlight = {
                "CursorColumn",
                "Whitespace",
            }

            require("ibl").setup({
                indent = { highlight = highlight, char = "|" },
            })
        end
    }
}
