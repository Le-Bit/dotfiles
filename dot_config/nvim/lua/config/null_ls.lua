local null_ls = require("null-ls")
local typescript = require("typescript")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.codespell,
    require("typescript.extensions.null-ls.code-actions"),
  },
  on_attach = on_attach,
})
