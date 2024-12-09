return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        natural_order = true,
        show_hidden = true,
      },
      win_options = {
        wrap = true,
      },
    },
  },
}
