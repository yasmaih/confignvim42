return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      -- local logo = [[
      --      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
      --      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
      --      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
      --      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
      --      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      --      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      -- ]]
      --  _______           __       __
      -- |       \         |  \     |  \
      -- | ▓▓▓▓▓▓▓\ ______ | ▓▓   __| ▓▓____   ______   ______   ______  _______
      -- | ▓▓  | ▓▓/      \| ▓▓  /  \ ▓▓    \ |      \ /      \ /      \|       \
      -- | ▓▓  | ▓▓  ▓▓▓▓▓▓\ ▓▓_/  ▓▓ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\
      -- | ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓   ▓▓| ▓▓  | ▓▓/      ▓▓ ▓▓   \▓▓ ▓▓    ▓▓ ▓▓  | ▓▓
      -- | ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓\| ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓     | ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓
      -- | ▓▓    ▓▓\▓▓     \ ▓▓  \▓▓\ ▓▓  | ▓▓\▓▓    ▓▓ ▓▓      \▓▓     \ ▓▓  | ▓▓
      --  \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓\▓▓       \▓▓▓▓▓▓▓\▓▓   \▓▓
      --   ______________________________________________________________________
      --  |░▓                                   ___                             ░\
      --   \▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      --     ▓                                                                  ▓

      local logo = [[
 ____            __      __                                       
/\  _`\         /\ \    /\ \                                      
\ \ \/\ \     __\ \ \/'\\ \ \___      __     _ __    __    ___    
 \ \ \ \ \  /'__`\ \ , < \ \  _ `\  /'__`\  /\`'__\/'__`\/' _ `\  
  \ \ \_\ \/\  __/\ \ \\`\\ \ \ \ \/\ \L\.\_\ \ \//\  __//\ \/\ \ 
   \ \____/\ \____\\ \_\ \_\ \_\ \_\ \__/.\_\\ \_\\ \____\ \_\ \_\
    \/___/  \/____/ \/_/\/_/\/_/\/_/\/__/\/_/ \/_/ \/____/\/_/\/_/
                                                                  
                                                                  
]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
          { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
          { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
          { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },

  --   {
  --     "goolord/alpha-nvim",
  --     lazy = false,
  --     event = "VimEnter",
  --     enabled = true,
  --     init = false,
  --     opts = function()
  --       local dashboard = require("alpha.themes.dashboard")
  --       local logo = [[
  --  _______           __       __
  -- |       \         |  \     |  \
  -- | ▓▓▓▓▓▓▓\ ______ | ▓▓   __| ▓▓____   ______   ______   ______  _______
  -- | ▓▓  | ▓▓/      \| ▓▓  /  \ ▓▓    \ |      \ /      \ /      \|       \
  -- | ▓▓  | ▓▓  ▓▓▓▓▓▓\ ▓▓_/  ▓▓ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\
  -- | ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓   ▓▓| ▓▓  | ▓▓/      ▓▓ ▓▓   \▓▓ ▓▓    ▓▓ ▓▓  | ▓▓
  -- | ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓\| ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓     | ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓
  -- | ▓▓    ▓▓\▓▓     \ ▓▓  \▓▓\ ▓▓  | ▓▓\▓▓    ▓▓ ▓▓      \▓▓     \ ▓▓  | ▓▓
  --  \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓\▓▓       \▓▓▓▓▓▓▓\▓▓   \▓▓
  --   ______________________________________________________________________
  --  |░▓                                   ___                             ░\
  --   \▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
  --     ▓                                                                  ▓
  -- ]]
  --
  --       dashboard.section.header.val = vim.split(logo, "\n")
  --     -- stylua: ignore
  --     dashboard.section.buttons.val = {
  --       dashboard.button("f", " " .. " Find file",       "<cmd> lua LazyVim.pick()() <cr>"),
  --       dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
  --       dashboard.button("r", " " .. " Recent files",    [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
  --       dashboard.button("g", " " .. " Find text",       [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
  --       dashboard.button("c", " " .. " Config",          "<cmd> lua LazyVim.pick.config_files()() <cr>"),
  --       dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
  --       dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
  --       dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
  --       dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
  --     }
  --       for _, button in ipairs(dashboard.section.buttons.val) do
  --         button.opts.hl = "AlphaButtons"
  --         button.opts.hl_shortcut = "AlphaShortcut"
  --       end
  --       dashboard.section.header.opts.hl = "AlphaHeader"
  --       dashboard.section.buttons.opts.hl = "AlphaButtons"
  --       dashboard.section.footer.opts.hl = "AlphaFooter"
  --       dashboard.opts.layout[1].val = 8
  --       return dashboard
  --     end,
  --     config = function(_, dashboard)
  --       -- close Lazy and re-open when the dashboard is ready
  --       if vim.o.filetype == "lazy" then
  --         vim.cmd.close()
  --         vim.api.nvim_create_autocmd("User", {
  --           once = true,
  --           pattern = "AlphaReady",
  --           callback = function()
  --             require("lazy").show()
  --           end,
  --         })
  --       end
  --
  --       require("alpha").setup(dashboard.opts)
  --
  --       vim.api.nvim_create_autocmd("User", {
  --         once = true,
  --         pattern = "LazyVimStarted",
  --         callback = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           dashboard.section.footer.val = "⚡ Neovim loaded "
  --             .. stats.loaded
  --             .. "/"
  --             .. stats.count
  --             .. " plugins in "
  --             .. ms
  --             .. "ms"
  --           pcall(vim.cmd.AlphaRedraw)
  --         end,
  --       })
  --     end,
  --   },
}
