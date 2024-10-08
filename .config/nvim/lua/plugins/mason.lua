return {
  {
    "williamboman/mason.nvim",
    config = function(_, opts)
      require("mason").setup(opts)
    end,
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
    dependencies = { "williamboman/mason.nvim" },
    opts = require("config.mason"),
  },
}
