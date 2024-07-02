local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "biome", "cssls", "jsonls", "lua_ls", "prismals", "tailwindcss", "tsserver" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "jsonls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = function()
            local schema_store = require "schemastore"
            return schema_store.json.schemas()
          end,
          validate = { enable = true },
        },
      },
    }
  elseif lsp == "prismals" then
    lspconfig[lsp].setup {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
      end,
      on_init = on_init,
      capabilities = capabilities,
      settings = {
        prisma = {
          prismaFmtBinPath = vim.fn.exepath "prisma-fmt",
        },
      },
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end
