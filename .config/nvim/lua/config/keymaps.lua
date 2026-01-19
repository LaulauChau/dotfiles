-- --- LEADERS ---
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- --- VISUAL MODE (Indentation & Movement) ---
-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move selection up/down with auto-indenting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- --- NAVIGATION & CENTERING ---
-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered during scrolling and search jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- --- LIST NAVIGATION (Quickfix & Location) ---
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz")

-- --- SEARCH & UTILS ---
-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- External tools
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
