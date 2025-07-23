return {
  -- ===================================
  -- TOKYO NIGHT THEME
  -- ===================================
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Charge immédiatement
    priority = 1000, -- Charge en premier
    opts = {
      style = "night", -- "storm", "moon", "night", "day"
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
      sidebars = { "qf", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- Active le thème
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- ===================================
  -- CONFIGURE LAZYVIM POUR TOKYO NIGHT
  -- ===================================
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
