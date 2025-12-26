return {
	{
		"rose-pine/neovim",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
		name = "rose-pine",
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			options = {
				icons_enabled = true,
				globalstatus = true,
				component_separators = "",
				section_separators = "",
				theme = "rose-pine",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "diff", "diagnostics" },
				lualine_y = { "filetype" },
				lualine_z = { "location" },
			},
		},
	},

	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			-- `nvim-notify` is only needed, if you want to use the notification view.
			-- If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				opts = {
					render = "compact",
					stages = "static",
					timeout = 1500,
				},
			},
		},
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
	},
}
