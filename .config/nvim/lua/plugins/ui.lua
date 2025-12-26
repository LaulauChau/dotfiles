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
			options = {
				globalstatus = true,
				component_separators = "",
				section_separators = "",
				theme = "rose-pine",
			},
			sections = {
				lualine_b = { "branch" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "diff", "diagnostics" },
				lualine_y = { "filetype" },
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
		opts = {},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
