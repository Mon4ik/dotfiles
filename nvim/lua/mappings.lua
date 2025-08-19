require("nvchad.mappings")

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })

-- unmap all terminal keymaps
unmap("t", "<C-x>")
unmap("n", "<leader>h")
unmap("n", "<leader>v")
unmap({ "n", "t" }, "<A-v>")
unmap({ "n", "t" }, "<A-h>")
unmap({ "n", "t" }, "<A-i>")

-- remap file formatting
unmap({ "n", "x" }, "<leader>fm") -- format file
map({ "n", "x" }, "<C-f>", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- remap nvim tree toggle
unmap("n", "<C-n>") -- NvimTreeToggle
unmap("n", "<leader>e") -- NvimTreeFocus
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
