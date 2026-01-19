return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				natural_order = true,
				show_hidden = true,
				is_always_hidden = function(name)
					return name == ".." or name == ".git"
				end,
			},
			win_options = {
				signcolumn = "no",
			},
		},
	}
}
