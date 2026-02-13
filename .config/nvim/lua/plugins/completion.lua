return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      appearance = {
        nerd_font_variant = "mono",
        use_nvim_cmp_as_default = true,
      },

      fuzzy = {
        implementation = "lua",
      },

      keymap = {
        preset = "super-tab",
      },

      signature = { enabled = true, window = { border = "single" } },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    version = "1.*"
  },
}
