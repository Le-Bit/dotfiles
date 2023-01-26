require("luasnip.loaders.from_vscode").lazy_load()
local snippets_folder = vim.fn.stdpath("config") .. "/lua/cmp_config/snippets/lang"
require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_folder })
