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
		opts = function()
			local util = require("conform.util")

			local function has_any(path, files)
				return vim.fs.find(files, { upward = true, path = path })[1] ~= nil
			end

			local biome_configs = { "biome.json", "biome.jsonc" }
			local prettier_configs = {
				"prettier.config.js",
				"prettier.config.cjs",
				"prettier.config.mjs",
				"prettier.config.ts",
				"prettier.config.cts",
				"prettier.config.mts",
			}

			return {
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},

				formatters_by_ft = {
					javascript = { "js_project_formatter" },
					javascriptreact = { "js_project_formatter" },
					typescript = { "js_project_formatter" },
					typescriptreact = { "js_project_formatter" },
					css = { { "prettierd", "prettier" } },
					html = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					python = { "black", "isort" },
					rust = { "rustfmt" },
					terraform = { "terraform_fmt" },
					yaml = { { "prettierd", "prettier" } },
					go = { "gofumpt", "goimports" },
				},

				formatters = {
					-- Decide per project:
					-- 1. Prettier if prettier.config.*
					-- 2. Biome if biome.json(c)
					-- 3. Fallback: Prettier defaults (prettierd/prettier) – no Biome
					js_project_formatter = {
						run = function(_, ctx)
							local path = ctx.filename or vim.loop.cwd()

							-- 1. Project uses Prettier
							if has_any(path, prettier_configs) then
								return require("conform").format({
									bufnr = ctx.buf,
									formatters = { "prettier_project" },
								})
							end

							-- 2. Project uses Biome
							if has_any(path, biome_configs) then
								return require("conform").format({
									bufnr = ctx.buf,
									formatters = { "biome_project" },
								})
							end

							-- 3. No config: use Prettier defaults (spaces)
							return require("conform").format({
								bufnr = ctx.buf,
								formatters = { "prettierd", "prettier" },
							})
						end,
					},

					-- Biome: ONLY when there’s a Biome config
					biome_project = {
						command = "biome",
						args = { "format", "--stdin-file-path", "$FILENAME" },
						stdin = true,
						condition = function(ctx)
							return has_any(ctx.filename, biome_configs)
						end,
						cwd = util.root_file(biome_configs),
					},

					-- Prettier with prettier.config.*
					prettier_project = {
						command = "prettier",
						args = { "--stdin-filepath", "$FILENAME" },
						stdin = true,
						prefer_local = "node_modules/.bin",
						condition = function(ctx)
							return has_any(ctx.filename, prettier_configs)
						end,
						cwd = util.root_file(prettier_configs),
					},

					-- Prettierd: generic fast fallback, still respects project configs
					prettierd = {
						prefer_local = "node_modules/.bin",
					},
				},
			}
		end,
	},
}
