return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to rtp
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"go",
				"hcl",
				"helm",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"rust",
				"templ",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
		},
	},
}
