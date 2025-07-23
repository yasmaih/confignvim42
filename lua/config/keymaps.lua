-- =====================================
-- KEYMAPS ÉCOLE 42 - SIMPLES ET EFFICACES
-- Remplace le contenu de ~/.config/nvim/lua/config/keymaps.lua
-- =====================================

-- Fonction header 42
local function insert_42_header()
  local filename = vim.fn.expand("%:t")
  if filename == "" then
    filename = "unnamed.c"
  end

  local login = "yasmine.aichi" -- 🔥 TON LOGIN
  local email = "yasmine.aichi@student.42.fr" -- 🔥 TON EMAIL
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
      .. "###   ########.fr      */",
    "/*                                                                            */",
    "/* ************************************************************************** */",
    "",
  }

  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
  print("✅ Header 42 inséré pour " .. filename)
end

local map = vim.keymap.set

-- =====================================
-- HEADER 42 (touches qui marchent à coup sûr)
-- =====================================
map("n", "<F1>", insert_42_header, { desc = "42 Header" })
map("n", "<F2>", insert_42_header, { desc = "42 Header" }) -- Backup
map("n", "<leader>42", insert_42_header, { desc = "42 Header" }) -- Alternative leader

-- =====================================
-- COMPILATION ÉCOLE 42 (touches directes)
-- =====================================
map("n", "<F5>", "<cmd>!gcc -Wall -Wextra -Werror %<CR>", { desc = "Compile C (42)" })
map("n", "<F6>", "<cmd>!gcc -Wall -Wextra -Werror % -o %:r && ./%:r<CR>", { desc = "Compile + Run" })

-- =====================================
-- RACCOURCIS SUPER SIMPLES
-- =====================================
-- Sauvegarder
map("n", ";;", "<cmd>w<CR>", { desc = "Save file" })
-- Header avec double-tap
map("n", "hh", insert_42_header, { desc = "42 Header (double h)" })
-- Compile avec double-tap
map("n", "cc", "<cmd>!gcc -Wall -Wextra -Werror %<CR>", { desc = "Compile C (double c)" })

-- =====================================
-- GIT SIMPLE
-- =====================================
map("n", "<leader>ga", "<cmd>!git add .<CR>", { desc = "Git add all" })
map("n", "<leader>gp", "<cmd>!git push<CR>", { desc = "Git push" })
map("n", "<leader>gs", "<cmd>!git status<CR>", { desc = "Git status" })

-- =====================================
-- NAVIGATION DE BASE
-- =====================================
-- Mode insertion
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- Quitter
map("n", ";q", "<cmd>q<CR>", { desc = "Quit" })
map("n", ";x", "<cmd>wq<CR>", { desc = "Save and quit" })

-- Buffers avec Tab (si ça marche encore)
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- =====================================
-- NORME 42
-- =====================================
map("n", "<leader>cn", "<cmd>!norminette %<CR>", { desc = "Check Norm 42" })
map("n", "<leader>ci", "<cmd>set list!<CR>", { desc = "Toggle invisible chars" })

print("✅ Keymaps École 42 chargés ! Touches principales :")
print("  F1 ou F2 ou hh = Header 42")
print("  F5 = Compile")
print("  F6 = Compile + Run")
print("  ;; = Save")
print("  cc = Compile (double c)")
