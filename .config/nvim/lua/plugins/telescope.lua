return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			require("telescope").load_extension("fzf")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Telescope find files" },
			{
				"<leader>fg",
				function()
					require("config.telescope.multigrep")()
				end,
				desc = "Telescope multi grep",
			},
			{ "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Telescope buffers" },
			{ "<leader>fd", "<CMD>Telescope diagnostics<CR>", desc = "Telescope diagnostics" },
			{ "<leader>fh", "<CMD>Telescope help-tags<CR>", desc = "Telescope help tags" },
		},
		opts = {
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
		},
	},
}
