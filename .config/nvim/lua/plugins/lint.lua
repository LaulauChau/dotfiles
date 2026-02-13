return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- Web Dev
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				css = { "stylelint" },

				-- Infrastructure
				go = { "golangcilint" },
				yaml = { "yamllint" },
				dockerfile = { "hadolint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = lint_augroup,
				callback = function()
					-- Get configured linters for current filetype
					local names = lint._resolve_linter_by_ft(vim.bo.filetype)
					if not names or #names == 0 then
						return
					end

					-- Filter to only linters that exist
					local available = {}
					for _, name in ipairs(names) do
						local linter = lint.linters[name]
						if linter and type(linter.cmd) == "string" and vim.fn.executable(linter.cmd) == 1 then
							table.insert(available, name)
						end
					end

					-- Only lint if we have available linters
					if #available > 0 then
						lint.try_lint(available)
					end
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				local names = lint._resolve_linter_by_ft(vim.bo.filetype)
				if not names or #names == 0 then
					vim.notify("No linters configured for this filetype", vim.log.levels.INFO)
					return
				end

				local available = {}
				for _, name in ipairs(names) do
					local linter = lint.linters[name]
					if linter and type(linter.cmd) == "string" and vim.fn.executable(linter.cmd) == 1 then
						table.insert(available, name)
					end
				end

				if #available > 0 then
					lint.try_lint(available)
					vim.notify("Running linters: " .. table.concat(available, ", "), vim.log.levels.INFO)
				else
					vim.notify("No linters available (install with :MasonToolsInstall)", vim.log.levels.WARN)
				end
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
