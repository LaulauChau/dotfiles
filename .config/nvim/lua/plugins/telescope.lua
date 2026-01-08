return {
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		--@type snacks.Config
		opts = {
			picker = {
				enabled = true,
				layout = { style = "telescope" },
				ui_select = true,
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Tags",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep({})
				end,
				desc = "Multi Grep",
			},
		},
	},
}
