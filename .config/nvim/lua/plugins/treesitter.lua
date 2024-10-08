return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    cmd = { "TSBufDisable", "TSBufEnable", "TSInstall", "TSModuleInfo" },
    dependencies = {
      "apple/pkl-neovim",
      "windwp/nvim-ts-autotag",
    },
    event = { "BufNewFile", "BufReadPost" },
    opts = {
      autotag = {
        enable = true,
        enable_close = true,
        enable_close_on_slash = true,
        enable_rename = true,
        filetypes = { "html", "js", "jsx", "ts", "tsx", "xml" },
      },
      ensure_installed = {
        "css",
        "go",
        "javascript",
        "lua",
        "pkl",
        "templ",
        "tsx",
        "typescript",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
  },
}
