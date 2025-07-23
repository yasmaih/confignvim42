-- =====================================
-- OPTIONS ÉCOLE 42 + PERSONNELLES
-- Conformes à la Norme 42 v4.1
-- =====================================

local opt = vim.opt

-- =====================================
-- OPTIONS DE BASE
-- =====================================
opt.autowrite = true -- Auto save
opt.wrap = false -- No line wra v
opt.clipboard = "unnamedplus" -- Système clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide markup
opt.confirm = true -- Confirm avant exit
opt.cursorline = true -- Highlight ligne courante
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Recherche insensible casse
opt.inccommand = "nosplit" -- Preview substitute
opt.laststatus = 3 -- Global statusline
opt.mouse = "a" -- Mouse support
opt.number = true -- Line numbers
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Max popup entries
opt.relativenumber = false -- Pas de relative numbers
opt.scrolloff = 4 -- Lignes de contexte
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Pas de mode (statusline le fait)
opt.sidescrolloff = 8 -- Colonnes de contexte
opt.signcolumn = "yes" -- Toujours show signcolumn
opt.smartcase = true -- Smart case search
--opt.smartindent = true -- Smart indent
opt.spelllang = { "fr" }
opt.splitbelow = true -- New windows below
opt.splitkeep = "screen"
opt.splitright = true -- New windows right
opt.termguicolors = true -- True colors
opt.timeoutlen = 300
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.updatetime = 200 -- Faster updates
opt.virtualedit = "block" -- Visual block mode
--opt.wildmode = "longest:full,full" -- Command completion
opt.winminwidth = 5 -- Min window width

-- =====================================
-- NORME 42 STRICTE (du PDF officiel)
-- =====================================

-- INDENTATION (Section III.2)
-- "You must indent your code with 4-char-long tabulations"
-- "This is not the same as 4 spaces, we're talking about real tabulations here (ASCII char number 9)"
opt.tabstop = 4 -- Tabulation = 4 espaces visuels
opt.shiftwidth = 4 -- Indentation = 4 espaces
opt.expandtab = false -- CRUCIAL: Vraies tabulations (ASCII 9)

-- LONGUEUR LIGNES (Section III.2)
-- "Each line must be at most 80 columns wide, comments included"
opt.colorcolumn = "80" -- Ligne guide à 80 caractères

-- CARACTÈRES INVISIBLES
-- Pour détecter les violations de norme
opt.list = true
opt.listchars = {
  tab = "→ ", -- Visualiser les tabulations
  trail = "•", -- Espaces en fin de ligne (INTERDITS)
  extends = "⟩", -- Ligne trop longue
  precedes = "⟨", -- Ligne coupée
  nbsp = "␣", -- Espaces insécables
}

-- Fichiers
opt.swapfile = false -- Pas de swap files
opt.backup = false -- Pas de backups
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- =====================================
-- AUTO-COMMANDES NORME 42
-- =====================================

-- Configuration OBLIGATOIRE pour fichiers C et H
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h" },
  callback = function()
    -- Force les options norme 42 pour C
    vim.opt_local.expandtab = false -- Vraies tabulations
    vim.opt_local.tabstop = 4 -- 4 espaces visuels
    vim.opt_local.shiftwidth = 4 -- Indentation 4
    --vim.opt_local.smartindent = true -- Smart indent
    vim.opt_local.colorcolumn = "80" -- Limite 80 colonnes

    -- Indentation C spécifique
    --vim.opt_local.cinoptions = ":0,l1,t0,g0,(0"
  end,
})

-- DÉTECTION VIOLATIONS NORME 42
-- Highlighter les espaces en fin de ligne (INTERDIT par norme)
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  pattern = { "*.c", "*.h" },
  callback = function()
    -- Highlighter en rouge les espaces/tabs en fin de ligne
    vim.cmd([[match ErrorMsg /\s\+$/]])
  end,
})

-- Auto-nettoyage des espaces trailing (optionnel)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Fix conceallevel pour JSON
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- =====================================
-- CONFIRMATION CHARGEMENT
-- =====================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("✅ Tokyo Night + École 42 config chargée")
    print("📏 Tabulations: " .. vim.o.tabstop .. " espaces | ExpandTab: " .. tostring(vim.o.expandtab))
    print("📐 Limite: " .. vim.o.colorcolumn .. " colonnes")
  end,
})
