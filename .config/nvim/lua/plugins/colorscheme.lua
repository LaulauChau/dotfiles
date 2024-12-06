return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
	      variant = "moon"
      })

      vim.cmd([[colorschem rose-pine]])
    end,
    name = "rose-pine",
    priority = 1000,
  },
}
