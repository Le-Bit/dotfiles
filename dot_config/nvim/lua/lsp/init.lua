-- Setup neovim lua configuration
-- require('neodev').setup()
-- -- Turn on lsp status information
-- require('fidget').setup()
-- -- include lsp-zero config
-- require('lsp.lsp-zero')
-- ---------------------------------------------------------------------------
-- LSP settings.

-- Setup neovim lua configuration
require("neodev").setup()
-- Turn on lsp status information
require("fidget").setup()
-- Mason
require("lsp.mason")
-- Cmp
require("lsp.cmp")
-- null-ls
require("lsp.null-ls")
