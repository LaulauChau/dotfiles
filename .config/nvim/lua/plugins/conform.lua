local function web_formatter(bufnr)
	local has_biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
		path = vim.api.nvim_buf_get_name(bufnr),
		upward = true,
	})[1]

	return has_biome and { "biome" } or { "prettierd" }
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

return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		opts = function()
			local opts = {
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},

				formatters_by_ft = {
					go = { "gofumpt", "goimports" },
					lua = { "stylua" },
					markdown = { "prettierd", "prettier" },
					python = { "black", "isort" },
					rust = { "rustfmt" },
					terraform = { "terraform_fmt" },
					yaml = { "prettierd", "prettier" },
					["_"] = { "trim_whitespace" },
				},
			}

			for _, ft in ipairs(fmt_filetypes) do
				opts.formatters_by_ft[ft] = web_formatter
			end

			return opts
		end,
	},
}
