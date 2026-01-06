return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				dockerfile = { "hadolint" },
				sh = { "shellcheck" },
				terraform = { "tflint" },
				yaml = { "actionlint" },
			}

			local function get_linter()
				local bufnr = vim.api.nvim_get_current_buf()
				local ft = vim.bo[bufnr].filetype
				local web_types = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

				if vim.tbl_contains(web_types, ft) then
					-- Check for biome config
					local name = vim.fs.root(bufnr, { "biome.json", "biome.jsonc" }) and "biome" or "eslint_d"

					-- Ensure the linter definition exists in nvim-lint
					-- and the binary is actually on the system
					if lint.linters[name] and vim.fn.executable(lint.linters[name].cmd) == 1 then
						return name
					end
				end
				return nil
			end

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					lint.try_lint()

					local dynamic_linter = get_linter()

					if dynamic_linter then
						lint.try_lint(dynamic_linter)
					end
				end,
			})
		end,
	},
}
