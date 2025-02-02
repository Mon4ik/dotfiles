return {
   {
        "neoclide/coc.nvim",
        branch = "release",
        config = function ()
            vim.g.coc_global_extensions = {
                "coc-json",
                "coc-lua",
                "coc-pyright",
                "coc-rust-analyzer",
                "coc-docker",
                "coc-yaml",
                "coc-sql"
            }
        end
    }
}
