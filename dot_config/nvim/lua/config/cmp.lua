local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50}),
    native_menu = false,
    ghost_text = true,
  },
  mapping = require('mappings').cmp_mappings,
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  })
})
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', { sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

