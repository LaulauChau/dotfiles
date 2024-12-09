return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Telescope find files" },
      { "<leader>fg", "<CMD>Telescope live_grep<CR>", desc = "Telescope live grep" },
      { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Telescope buffers" },
      { "<leader>fh", "<CMD>Telescope help-tags<CR>", desc = "Telescope help tags" },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
				  "rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
      },
    },
  },
}
