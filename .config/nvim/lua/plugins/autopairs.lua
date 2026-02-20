return {
  {
    "saghen/blink.pairs",
    version = "*",
    dependencies = "saghen/blink.download",
    opts = {
      mappings = { enabled = true },
      highlights = { enabled = true },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
}
