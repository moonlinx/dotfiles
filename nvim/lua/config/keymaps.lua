-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- Change colon line key to semi colon
keymap.set("", ":", ";", { desc = "swap colon with semi colon" })
keymap.set("", ";", ":", { desc = "swap colon with semi colon" })
-- Noice
vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", { noremap = true })
