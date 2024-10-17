return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["*"] = { "biome", "prettierd" },
        css = { "biome", "prettierd" },
        html = { "biome", "prettierd" },
        go = { "gofumpt", "goimports", "golines" },
        javascript = { "biome" },
        lua = { "stylua" },
        nix = { "alejandra" },
      },
      formatters = {
        biome = {
          prepend_args = { "check", "--no-errors-on-unmatched", "--files-ignore-unknown=true", "--write" },
        },
      },
    },
  },
}
