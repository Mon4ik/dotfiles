return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            local function getColor(group, attr)
                return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
            end

            require("gruvbox").setup {
                overrides = {
                    SignColumn = { link = "Normal" },

                    SnacksPicker = { link = "Normal" },
                    SnacksPickerBorder = { link = "Normal" },
                    SnacksPickerGitStatusUntracked = { link = "GruvboxFg3" },

                    -- Fix LSP sign column:
                    GruvboxYellowSign = { bg = getColor("Normal", "bg#") },
                    GruvboxRedSign = { bg = getColor("Normal", "bg#") },
                    GruvboxAquaSign = { bg = getColor("Normal", "bg#") },
                    GruvboxBlueSign = { bg = getColor("Normal", "bg#") },
                    GruvboxGreenSign = { bg = getColor("Normal", "bg#") },
                    GruvboxOrangeSign = { bg = getColor("Normal", "bg#") },
                    GruvboxPurpleSign = { bg = getColor("Normal", "bg#") },
                }
            }

            vim.opt.background = "dark"
            vim.cmd.colorscheme("gruvbox")
        end
    }
}
