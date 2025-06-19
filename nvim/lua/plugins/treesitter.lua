return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            treesitters = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html", "svelte", "tsx", "css" }
        },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = opts.treesitters,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
