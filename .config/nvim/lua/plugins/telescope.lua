return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<leader>fg", require("config.telescope.multigrep"))
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
