local keyset = vim.keymap.set

keyset("n", "<C-b>", "make<CR>")

-- copied from https://stackoverflow.com/a/76880300/15193189
keyset({'n'}, '<C-c>', '"+y$')
keyset({'v'}, '<C-c>', '"+y')

-- Looking for old Coc keymaps?
-- Here: https://github.com/Mon4ik/dotfiles/blob/32e1d35475d23104f515d15041f382b7356b343c/nvim/lua/config/keymaps.lua
