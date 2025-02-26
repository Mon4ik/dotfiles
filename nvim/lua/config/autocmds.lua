-- Set 2 spaces for yaml
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "*.yaml", "*.yml",
        "*.sql"
    },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end
})
----[[ LSP ]]----

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd([[set signcolumn=yes]])
    end,
})
--
--
-- -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
-- vim.api.nvim_create_augroup("CocGroup", {})
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = "CocGroup",
--     command = "silent call CocActionAsync('highlight')",
--     desc = "Highlight symbol under cursor on CursorHold"
-- })
--
-- -- Setup formatexpr specified filetype(s)
-- vim.api.nvim_create_autocmd("FileType", {
--     group = "CocGroup",
--     pattern = "typescript,json",
--     command = "setl formatexpr=CocAction('formatSelected')",
--     desc = "Setup formatexpr specified filetype(s)."
-- })
--
-- -- Update signature help on jump placeholder
-- vim.api.nvim_create_autocmd("User", {
--     group = "CocGroup",
--     pattern = "CocJumpPlaceholder",
--     command = "call CocActionAsync('showSignatureHelp')",
--     desc = "Update signature help on jump placeholder"
-- })
--
