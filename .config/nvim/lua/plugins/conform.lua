return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		opts = function()
			local function get_web_formatter(bufnr)
				if vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) then
					return { "biome" }
				end

				return { "prettierd" }
			end

			local fmt_filetypes = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"jsonc",
				"typescript",
				"typescriptreact",
			}

			local opts = {
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},

				formatters_by_ft = {
					go = { "gofumpt", "goimports" },
					hcl = { "terraform_fmt" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					rust = { "rustfmt" },
					sh = { "shfmt" },
					terraform = { "terraform_fmt" },
					yaml = { "prettierd" },
					["_"] = { "trim_whitespace" },
				},
			}

			for _, ft in ipairs(fmt_filetypes) do
				opts.formatters_by_ft[ft] = get_web_formatter
			end

			return opts
		end,
	},
}
