local function web_linter(bufnr, biome_tool, fallback_tool)
	local has_biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
		path = vim.api.nvim_buf_get_name(bufnr),
		upward = true,
	})[1]
	return has_biome and { biome_tool } or { fallback_tool }
end

local lint_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				dockerfile = { "hadolint" },
				terraform = { "trivy" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					local ft = vim.bo.filetype
					if vim.tbl_contains(lint_filetypes, ft) then
						-- Dynamic switch for web
						lint.try_lint(web_linter(0, "biome", "eslint_d"))
					else
						-- Standard lookup for others (infra/etc)
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
