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
					Snacks.picker.grep({
						live = true,
						title = "Multi Grep",
						on_change = function(picker)
							local input = picker.input.text
							-- Split by double space to handle pattern + glob
							local pieces = vim.split(input, "  ", { plain = true })

							-- Dynamically update the ripgrep arguments
							picker:set_filter({
								search = pieces[1] or "",
								glob = pieces[2] or "",
							})
						end,
					})
				end,
				desc = "Multi Grep (pattern  glob)",
			},
		},
	},
}
