return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignore = false,
          visible = true,
        },
      },
      window = {
        position = "right",
      },
    },
  },
}