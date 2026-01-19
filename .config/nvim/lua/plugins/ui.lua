return {
  {
    "rose-pine/neovim",
    config = function()
      vim.cmd("colorscheme rose-pine")

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
    name = "rose-pine",
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        component_separators = "",
        section_separators = "",
        theme = "rose-pine",
      },
      sections = {
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diff", "diagnostics" },
        lualine_y = { "filetype" },
      },
    },
  },

}
