return {
  {
    "saecki/crates.nvim",
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
    ft = { "rust", "toml" },
  },
}
