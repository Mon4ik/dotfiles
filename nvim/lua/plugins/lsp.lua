return {
    {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
            vim.g.coc_global_extensions = {
                "coc-json",
                "coc-lua",
                "coc-rust-analyzer",
                "coc-docker",
                "coc-yaml",
                "coc-sql",
                "coc-toml"
            }

            vim.cmd([[set nu]])
            vim.cmd([[hi coc_err_hi ctermfg=1 ctermbg=15]])
            vim.cmd([[sign define coc_err numhl=coc_err_hi]])
            vim.cmd([[sign place 1 line=2 name=coc_err]])            
        end
    }
}
