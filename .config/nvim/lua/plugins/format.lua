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
        -- Lua
        lua = { "stylua" },

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
        sh = { "shfmt" },
        bash = { "shfmt" },
        python = { "ruff_format" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        yaml = { "prettierd" },
        yml = { "prettierd" },

        -- Markdown
        markdown = { "prettierd" },
      },
    },
  },
}
