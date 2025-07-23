-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- local transparent = os.getenv("TRANSPARENT_BACKGROUND") or "false"
-- if transparent == "true" then
--   vim.api.nvim_create_autocmd({ "colorscheme" }, {
--     pattern = { "*" },
--     callback = function(ev)
--
--       -- print(string.format("event fired: %s", vim.inspect(ev)))
--     end,
--   })
-- end
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
--       -- Get the current buffer
--       require("neo-tree.command").execute({ position = "current", toggle = false })
--       local bufnr = vim.api.nvim_get_current_buf()
--       vim.notify("one")
--       vim.notify(vim.api.nvim_get_option_value("buftype", { buf = bufnr }))
--       vim.notify("two")
--       vim.notify(vim.api.nvim_buf_get_name(bufnr))
--
--       -- vim.api.nvim_buf_delete(bufnr, { force = true })
--       -- Check if it's an empty, unnamed buffer and delete it
--       if vim.api.nvim_buf_get_name(bufnr) == "" and vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "" then
--         vim.api.nvim_buf_delete(bufnr, { force = true })
--       end
--     end
--   end,
-- })
-- =====================================
-- AUTOCMDS ÉCOLE 42 - INCONTOURNABLES
-- Se charge APRÈS tout le reste, donc impossible à écraser
-- =====================================

-- Fonction header 42
local function insert_42_header()
  local filename = vim.fn.expand("%:t")
  if filename == "" then
    filename = "unnamed.c"
  end

  local login = "yasmine.aichi" -- 🔥 TON LOGIN
  local email = "yasmine.aichi@learner.42.tech" -- 🔥 TON EMAIL
  local date = os.date("%Y/%m/%d %H:%M:%S")

  local header = {
    "/* ************************************************************************** */",
    "/*                                                                            */",
    "/*                                                        :::      ::::::::   */",
    "/*   " .. filename .. string.rep(" ", math.max(0, 51 - #filename)) .. ":+:      :+:    :+:   */",
    "/*                                                    +:+ +:+         +:+     */",
    "/*   By: "
      .. login
      .. " <"
      .. email
      .. ">"
      .. string.rep(" ", math.max(0, 42 - #login - #email - 3))
      .. "+#+  +:+       +#+        */",
    "/*                                                +#+#+#+#+#+   +#+           */",
    "/*   Created: "
      .. date
      .. " by "
      .. login
      .. string.rep(" ", math.max(0, 18 - #login))
      .. "#+#    #+#             */",
    "/*   Updated: "
      .. date
      .. " by "
      .. login
      .. string.rep(" ", math.max(0, 18 - #login))
      .. "###   ########.fr       */",
    "/*                                                                            */",
    "/* ************************************************************************** */",
    "",
  }

  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
  print("✅ Header 42 inséré pour " .. filename)
end

-- =====================================
-- AUTOCMD QUI SE CHARGE EN DERNIER
-- =====================================
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy", -- Se charge après TOUT le reste
  callback = function()
    -- Nettoyer les anciens mappings
    pcall(vim.keymap.del, "n", "<F1>")
    pcall(vim.keymap.del, "n", "gh")

    -- Attendre un peu puis mapper
    vim.defer_fn(function()
      -- Keymaps École 42 FORCÉS
      vim.keymap.set("n", "<F1>", insert_42_header, { desc = "42 Header", force = true })
      vim.keymap.set("n", "gh", insert_42_header, { desc = "42 Header (quick)", force = true })

      -- Autres keymaps École 42
      vim.keymap.set("n", "gc", "<cmd>!gcc -Wall -Wextra -Werror %<CR>", { desc = "Compile C (42)", force = true })
      vim.keymap.set(
        "n",
        "gr",
        "<cmd>!gcc -Wall -Wextra -Werror % -o %:r && ./%:r<CR>",
        { desc = "Compile + Run", force = true }
      )
      vim.keymap.set("n", "gn", "<cmd>!norminette %<CR>", { desc = "Check Norm 42", force = true })
      vim.keymap.set("n", "gi", "<cmd>set list!<CR>", { desc = "Toggle invisible chars", force = true })

      -- Git
      vim.keymap.set("n", "ga", "<cmd>!git add .<CR>", { desc = "Git add all", force = true })
      vim.keymap.set("n", "gp", "<cmd>!git push<CR>", { desc = "Git push", force = true })
      vim.keymap.set("n", "gs", "<cmd>!git status<CR>", { desc = "Git status", force = true })

      -- Navigation
      vim.keymap.set("n", ";;", "<cmd>w<CR>", { desc = "Save file", force = true })
      vim.keymap.set("n", ";q", "<cmd>q<CR>", { desc = "Quit", force = true })
      vim.keymap.set("n", ";x", "<cmd>wq<CR>", { desc = "Save and quit", force = true })

      -- Mode insertion
      vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", force = true })
      vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode", force = true })

      print("🚀 Keymaps École 42 FORCÉS chargés !")
    end, 500) -- Attendre 500ms pour être sûr
  end,
})
