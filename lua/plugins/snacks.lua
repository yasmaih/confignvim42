return {
  {
    "folke/snacks.nvim",
    -- @type snacks.Config
    keys = {
      --disabling defaults
      { "<C-/>", mode = { "n" }, false },
      -- floating terminal
      { "<leader>fT", mode = { "n" }, false },
      { "<leader>ft", mode = { "n" }, false },
      { "<c-/>", mode = { "n", "t" }, false },
      { "<c-_>", mode = { "n", "t" }, false },

      -- Terminal Mappings
      -- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
      -- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
    },
  }  -- map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
  -- map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
  -- map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })
  --
  -- -- Terminal Mappings
  -- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
  -- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

, -- -- floating terminal -- map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
  {

    "saghen/blink.cmp",
    opts = function(_, opts)
      local completion_toggle = Snacks.toggle({
        name = "Completion",
        get = function()
          return vim.b.completion
        end,
        set = function(state)
          vim.b.completion = state
        end,
      })

      local function toggle_completion()
        require("blink.cmp").hide()
        completion_toggle:toggle()
      end

      vim.keymap.set({ "n" }, "<leader>ac", toggle_completion, { desc = "Toggle Completion" })
      opts.enabled = function()
        return vim.b.completion
      end

      return opts
    end,
  },
}
