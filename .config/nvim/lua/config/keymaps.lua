-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Go to definition
vim.api.nvim_set_keymap(
  "n",
  "gd",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { desc = "Go to definition", noremap = true, silent = true }
)

-- Show references
vim.api.nvim_set_keymap(
  "n",
  "<leader>gr",
  "<cmd>Telescope lsp_references<CR>",
  { desc = "Show references", noremap = true, silent = true }
)

-- Show hover
vim.api.nvim_set_keymap(
  "n",
  "K",
  "<cmd>lua vim.lsp.buf.hover()<CR>",
  { desc = "Show hover", noremap = true, silent = true }
)
