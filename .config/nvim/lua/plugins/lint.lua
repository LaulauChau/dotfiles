return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			local function has_any(path, files)
				return vim.fs.find(files, { upward = true, path = path })[1] ~= nil
			end

			local biome_configs = { "biome.json", "biome.jsonc" }
			local eslint_configs = {
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
				"eslint.config.ts",
				"eslint.config.mts",
				"eslint.config.cts",
			}

			-- Biome linter
			lint.linters.biome = {
				cmd = "biome",
				stdin = true,
				args = { "lint", "--stdin-file-path", "$FILENAME" },
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%c %m", {
					source = "biome",
				}),
			}

			-- ESLint (eslint_d) – assumes flat config files only
			local eslint_d = require("lint").linters.eslint_d
			eslint_d.condition = function(ctx)
				return has_any(ctx.filename, eslint_configs)
			end

			-- Biome lint only if:
			-- - there is a Biome config
			-- - and NO ESLint flat config
			local biome_lint = lint.linters.biome
			biome_lint.condition = function(ctx)
				if has_any(ctx.filename, eslint_configs) then
					return false
				end
				return has_any(ctx.filename, biome_configs)
			end

			lint.linters_by_ft = {
				javascript = { "eslint_d", "biome" },
				javascriptreact = { "eslint_d", "biome" },
				typescript = { "eslint_d", "biome" },
				typescriptreact = { "eslint_d", "biome" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "[L]int buffer" })
		end,
	},
}
