return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--column",
						"--line-number",
						"--no-heading",
						"--smart-case",
						"--with-filename",
					},
					file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
					preview = {
						filesize_limit = 0.5, -- Don't preview files > 500KB
					},
				},
				extensions = {
					fzf = {}
				}
			})

			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")

			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

			require("config.telescope.multigrep").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}
