return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
        ensure_installed = {
          -- Web Dev
          "typescript",
          "javascript",
          "tsx",
          "jsx",
          "html",
          "css",
          "json",
          "jsonc",
          "markdown",
          "markdown_inline",

          -- Infrastructure
          "dockerfile",
          "yaml",
          "go",
        },
        highlight = {
          additional_vim_regex_highlighting = false,
          enable = true,
        },
        indent = {
          enable = true,
        },
        sync_install = false,
      })
    end,
    lazy = false,
  },
}
