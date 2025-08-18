require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

unmap({ "n", "x" }, "<leader>fm") -- format file
map({ "n", "x" }, "<C-f>", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

unmap("n", "<C-n>") -- NvimTreeToggle
unmap("n", "<leader>e") -- NvimTreeFocus

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

unmap("n", "<leader>b") -- buffer new
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "buffer new" })
