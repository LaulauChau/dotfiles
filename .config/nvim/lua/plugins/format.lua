return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    opts = {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        -- Web Dev
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },

        -- Infrastructure
        go = { "goimports", "gofmt" },
        yaml = { "prettierd" },
        yml = { "prettierd" },
      },
    },
  },
}
