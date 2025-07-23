return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto",
      component_separators = { left = "|>", right = "<|" },
    },
    winbar = {
      lualine_c = {
        { "filename", path = 1 },
      },
      lualine_x = {
        "filetype",
      },
    },
    inactive_winbar = {
      lualine_c = {
        { "filename", path = 0 },
      },
    },
  },
}
