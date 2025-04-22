return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
			formatters_by_ft = {
				css = { { "biome", "prettierd", "prettier" } },
				go = { "gofumpt", "goimports" },
				html = { { "prettierd", "prettier" } },
				javascript = { { "biome", "prettierd", "prettier" } },
				json = { { "biome", "prettierd", "prettier" } },
				lua = { "stylua" },
				python = { "black", "isort" },
				rust = { "rustfmt" },
				terraform = { "terraform_fmt" },
				typescript = { { "biome", "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
			},
		},
	},
}
