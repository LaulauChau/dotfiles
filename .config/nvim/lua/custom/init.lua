local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  pattern = "*.prisma",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
