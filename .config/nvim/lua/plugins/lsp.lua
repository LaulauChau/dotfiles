return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				float = { border = "single" },
				severity_sort = true,
				virtual_text = true,
			})

			require("mason").setup()

			require("mason-tool-installer").setup({
				ensure_installed = {
					"actionlint",
					"bash-language-server",
					"biome",
					"eslint_d",
					"gofumpt",
					"hadolint",
					"helm-ls",
					"goimports",
					"prettierd",
					"rust-analyzer",
					"shellcheck",
					"shfmt",
					"stylua",
					"terraform-ls",
					"tflint",
				},
			})

			local servers = {
				"bashls",
				"cssls",
				"dockerls",
				"docker_compose_language_service",
				"gopls",
				"helm_ls",
				"html",
				"jsonls",
				"marksman",
				"tailwindcss",
				"templ",
				"terraformls",
				"yamlls",
				"vtsls",
			}

			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})

			vim.iter(servers):each(function(server)
				vim.lsp.config(server, {
					capabilities = capabilities,
				})

				vim.lsp.enable(server)
			end)

			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemas = require("schemastore").yaml.schemas(),
						schemaStore = { enable = false, url = "" },
					},
				},
			})

			vim.lsp.enable("jsonls")
			vim.lsp.enable("yamlls")

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
					end

					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "Definition")
					map("grr", function()
						Snacks.picker.lsp_references()
					end, "References")
					map("gri", function()
						Snacks.picker.lsp_implementations()
					end, "Implementation")
					map("g0", function()
						Snacks.picker.lsp_symbols()
					end, "Symbols")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>cr", vim.lsp.buf.rename, "Rename")
				end,
			})
		end,
		dependencies = {
			"b0o/schemaStore.nvim",
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
	},
}
