return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
        ensure_installed = {
          -- Neovim
          "lua",
          "vim",
          "vimdoc",

          -- Web Dev
          "typescript",
          "javascript",
          "tsx",
          "jsx",
          "html",
          "css",
          "json",
          "jsonc",

          -- Infrastructure
          "bash",
          "dockerfile",
          "yaml",
          "toml",
          "hcl",          -- Terraform
          "go",
          "python",
          "rust",

          -- Markup/Config
          "markdown",
          "markdown_inline",
          "regex",
        },
        highlight = {
          additional_vim_regex_highlighting = false,
          enable = true,
        },
        sync_install = false,
      })
    end,
    lazy = false,
  },
}
