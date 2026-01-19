return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
		opts = {},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Formatters
				"stylua",
				"prettierd",
				"shfmt",
				"ruff",
				"goimports",

				-- Linters
				"eslint_d",
				"stylelint",
				"shellcheck",
				"golangci-lint",
				"yamllint",
				"tflint",
				"hadolint",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",

					-- Web Dev
					"vtsls",
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",

					-- Infrastructure
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"yamlls",
					"helm_ls",
					"terraformls",
					"gopls",
					"basedpyright",
					"rust_analyzer",
				},
				handlers = {
					function(server_name)
						vim.lsp.config(server_name, { capabilities = require("blink.cmp").get_lsp_capabilities() })
						vim.lsp.enable({ server_name })
					end,

					jsonls = function()
						vim.lsp.config("jsonls", {
							capabilities = require("blink.cmp").get_lsp_capabilities(),
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
						vim.lsp.enable("jsonls")
					end,

					yamlls = function()
						vim.lsp.config("yamlls", {
							capabilities = require("blink.cmp").get_lsp_capabilities(),
							settings = {
								yaml = {
									schemaStore = {
										enable = false,
										url = "",
									},
									schemas = require("schemastore").yaml.schemas(),
								},
							},
						})
						vim.lsp.enable("yamlls")
					end,
				},
			})
		end,
		dependencies = {
			{ "b0o/SchemaStore.nvim" },
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "mason-org/mason.nvim" },
			{ "mason-org/mason-lspconfig.nvim" },
			"saghen/blink.cmp",
		},
		event = { "BufNewFile", "BufReadPre" },
	},
}
