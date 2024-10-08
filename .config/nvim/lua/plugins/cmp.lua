return {
  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("config.others").luasnip(opts)
        end,
      },
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      return require("config.cmp")
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        copilot_node_command = "node", -- Node.js version must be > 16.x
        filetypes = {
          cvs = false,
          help = false,
          hgcommit = false,
          gitcommit = false,
          gitrebase = false,
          markdown = false,
          svn = false,
          yaml = false,
          ["."] = false,
        },
        panel = {
          auto_refresh = false,
          enabled = true,
          keymap = {
            accept = "<CR>",
            jump_prev = "[[",
            jump_next = "]]",
            open = "<M-CR>",
            refresh = "gr",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          auto_trigger = true,
          enabled = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_line = "<C-j>",
            accept_word = false,
            dismiss = "<C-]>",
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        server_opts_overrides = {},
      })
    end,
    cmd = "Copilot",
    event = "InsertEnter",
  },
}
