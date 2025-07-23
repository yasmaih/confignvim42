-- =====================================
-- KEYMAPS ÉCOLE 42 - SIMPLES ET EFFICACES
local map = vim.keymap.set

-- =====================================
-- HEADER 42 (touches qui marchent à coup sûr)
-- =====================================

map("n", "<F2>", ":CFormat42<CR>", { desc = "formatter 42", noremap = true, silent = true })
-- =====================================
-- COMPILATION ÉCOLE 42 (touches directes)
-- =====================================
map("n", "<F5>", "<cmd>!gcc -Wall -Wextra -Werror %<CR>", { desc = "Compile C (42)" })
map("n", "<F6>", function()
  local filename = vim.fn.expand("%")
  local output = vim.fn.expand("%:r")
  local compile_cmd = "gcc -Wall -Wextra -Werror " .. filename .. " -o " .. output

  -- Open a floating terminal window so nothing edits your buffer
  vim.cmd("botright split | terminal " .. compile_cmd .. " && ./" .. output)
end, { noremap = true, silent = true, desc = "Safe Compile + Run" })

-- ========================================
-- GESTION DES FENÊTRES (SPLITS)
-- ========================================

-- Diviser l'écran en plusieurs parties
map("n", "<leader>sv", function()
  vim.cmd("<C-w>v")
  vim.cmd("<C-w>=") -- Égalise automatiquement après split vertical
end, { desc = "Diviser verticalement (taille égale)" })

map("n", "<leader>sh", function()
  vim.cmd("<C-w>s")
  vim.cmd("<C-w>=") -- Égalise automatiquement après split horizontal
end, { desc = "Diviser horizontalement (taille égale)" })

map("n", "<leader>se", "<C-w>=", { desc = "Égaliser taille des fenêtres" })

map("n", "<leader>sx", function()
  vim.cmd("close")
  vim.cmd("<C-w>=") -- Égalise après fermeture
end, { desc = "Fermer fenêtre + égaliser" })
-- =====================================
-- RACCOURCIS SUPER SIMPLES
-- =====================================
-- Sauvegarder
map("n", ";;", "<cmd>w<CR>", { desc = "Save file" })
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

-- Quitter
map("n", ";q", "<leader>q<CR>", { desc = "Quit" })
map("n", ";x", "<leader>wq<CR>", { desc = "Save and quit" })

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
