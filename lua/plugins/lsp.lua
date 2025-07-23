-- local function dump(o)
--   if type(o) == "table" then
--     local s = "{ "
--     for k, v in pairs(o) do
--       if type(k) ~= "number" then
--         k = '"' .. k .. '"'
--       end
--       s = s .. "[" .. k .. "] = " .. dump(v) .. ","
--     end
--     return s .. "} "
--   else
--     return tostring(o)
--   end
-- end
--
--TODO Decide on a strategy to set linter lang
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfmt" },
        rust = { "rustfmt" },
      },
      formatters = {
        rustfmt = {
          command = "rustfmt",
          args = { "+nightly" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    -- function(a, b)
    -- vim.notify(dump(b))
    --
    -- print(a, b)
    -- return b
    opts = {
      -- Event to trigger linters
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      linters = {
        sqlfluff = {
          args = {
            "lint",
            "--format=json",
            -- note: users will have to replace the --dialect argument accordingly
            "--dialect=sqlite",
          },
        },
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    -- end,
  },
}
