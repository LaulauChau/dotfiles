return {
	{
		"williamboman/mason.nvim",
		config = true,
		lazy = false,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- JS/TS formatting & linting
				"biome",
				"eslint_d",
				"prettierd",

				-- Python
				"black",
				"isort",

				-- Go
				"gofumpt",
				"goimports",

				-- Lua
				"stylua",

				"hadolint",
				"trivy",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		config = function()
			local lsp_defaults = require("lspconfig").util.default_config

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

			-- LspAttach is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
					vim.keymap.set("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
					vim.keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
					vim.keymap.set("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
					vim.keymap.set("n", "go", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
					vim.keymap.set("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
					vim.keymap.set("n", "gs", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
					vim.keymap.set("n", "cr", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
					vim.keymap.set("n", "ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
					vim.keymap.set("n", "<leader>e", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
					vim.keymap.set("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", opts)
					vim.keymap.set("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", opts)
				end,
				desc = "LSP actions",
			})

			require("mason-lspconfig").setup({
				automatic_installation = true,

				ensure_installed = {
					-- Frontend
					"cssls",
					"html",
					"tailwindcss",
					"templ",
					"ts_ls",

					-- Backend
					"gopls",
					"pyright",
					"rust_analyzer",

					-- Infrastructure
					"dockerls",
					"lua_ls",
					"terraformls",
					"yamlls",

					-- General
					"jsonls",
					"marksman",
				},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					["gopls"] = function()
						require("lspconfig").gopls.setup({
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
									},
									gofumpt = true,
									staticcheck = true,
								},
							},
						})
					end,

					["jsonls"] = function()
						require("lspconfig").jsonls.setup({
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,

					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							settings = {
								typescript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayPropertyDeclarationTypeHints = true,
									},
								},
							},
						})
					end,

					["yamlls"] = function()
						require("lspconfig").yamlls.setup({
							settings = {
								yaml = {
									schemaStore = {
										enable = true,
										url = "https://www.schemastore.org/api/json/catalog.json",
									},
									schemas = require("schemastore").yaml.schemas(),
								},
							},
						})
					end,
				},
			})
		end,
		dependencies = {
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
		},
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"b0o/schemaStore.nvim",
		version = false,
	},
}
