return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"css",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
        "rust",
				"templ",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
		},
	},
}
