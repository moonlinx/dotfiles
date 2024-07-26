-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("", ":", ";", { desc = "swap colon with semi colon" })
keymap.set("", ";", ":", { desc = "swap colon with semi colon" })
