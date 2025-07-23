local bufnr = vim.api.nvim_get_current_buf()
local args_env = os.getenv("RUN_ARGS") or ""
local sep = os.getenv("RUN_ARGS_SEPARATOR") or "||"
local args = vim.split(args_env, sep, { trimempty = true })
local run = { "runnables" }
vim.list_extend(run, args)
vim.keymap.set("n", "<leader>a", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set("n", "<F10>", function()
  vim.cmd.RustLsp(run)
end)
