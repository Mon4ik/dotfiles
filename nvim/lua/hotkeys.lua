vim.keymap.set("n", "<C-b>", "make<CR>")
vim.keymap.set("n", "<C-t>", "<cmd>NvimTreeToggle<CR>")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "go", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)

vim.keymap.set("n", "<C-M-l>", vim.lsp.buf.format)
