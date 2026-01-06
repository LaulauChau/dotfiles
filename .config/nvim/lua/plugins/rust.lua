return {
	{
		"mrcjkb/rustaceanvim",
		config = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					default_settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							check = { command = "clippy" },
							checkOnSave = true,
						},
					},
				},
			}
		end,
		lazy = false,
		version = "^6",
	},
}
