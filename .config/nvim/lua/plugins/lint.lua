return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters.selene = {
        args = function()
          local filepath = vim.api.nvim_buf_get_name(0)
          local config_dir = vim.fn.stdpath 'config'
          if filepath:find(config_dir, 1, true) == 1 then return { '--config', config_dir .. '/.selene.toml', '-' } end
          return { '-' }
        end,
      }

      lint.linters_by_ft = {
        lua = { 'selene' },
        go = { 'golangci_lint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        dockerfile = { 'hadolint' },
        markdown = { 'markdownlint' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
