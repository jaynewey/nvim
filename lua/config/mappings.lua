vim.g.mapleader = '\\'

-- ctrl+w for deleting buffer
vim.keymap.set("n", "<C-w>", ":Bdelete<CR>")

-- keep selection after tabbing selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- keep cursor in center after jumps
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- disable highlight
vim.keymap.set("n", "//", vim.cmd.nohl)

-- move between splits
vim.keymap.set("n", "<leader><up>", "<C-w><up>")
vim.keymap.set("n", "<leader><down>", "<C-w><down>")
vim.keymap.set("n", "<leader><left>", "<C-w><left>")
vim.keymap.set("n", "<leader><right>", "<C-w><right>")

-- exit terminal mode with ESC
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- don't overwrite clipboard sometimes
vim.keymap.set("v", "p", '"_dP')  -- pasting
