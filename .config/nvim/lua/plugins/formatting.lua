return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        javascript = { { "biome", "prettierd", "prettier" } },
        typescript = { { "biome", "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        json = { { "biome", "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "biome", "prettierd", "prettier" } },
        go = { "gofumpt", "goimports" },
        terraform = { "terraform_fmt" },
      },
    },
  },
}
