return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				changedelete = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
			},
			current_line_blame = true,
		},
	},
}
