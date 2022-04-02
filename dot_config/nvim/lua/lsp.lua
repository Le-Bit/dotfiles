local lspconfig = require("lspconfig")
local configs = require('lspconfig/configs')
local null_ls = require("null-ls")
local cmp = require('cmp')
local lspkind = require('lspkind')


require('lspconfig').yamlls.setup{}

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_enable_code_actions = true,
      enable_formatting = true,
      formatter = "prettier",
    })
    ts_utils.setup_client(client)
    require('mappings').ts_on_attach(client, bufnr)
    require('mappings').on_attach(client, bufnr)
  end,
})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
  },
  on_attach = on_attach,
})

cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50}),
    native_menu = false,
    ghost_text = true,
  },
  mapping = require('mappings').cmp_mapping,
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  })
})
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', { sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

vim.lsp.protocol.make_client_capabilities().textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
