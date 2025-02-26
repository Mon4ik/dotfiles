local keyset = vim.keymap.set

keyset("n", "<C-b>", "make<CR>")
keyset("n", "<C-t>", "<cmd>NvimTreeToggle<CR>")

-- Looking for old Coc keymaps?
-- Here: https://github.com/Mon4ik/dotfiles/blob/32e1d35475d23104f515d15041f382b7356b343c/nvim/lua/config/keymaps.lua
