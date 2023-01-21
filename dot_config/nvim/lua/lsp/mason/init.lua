-- Setup mason so it can manage external tooling
local capabilities = require("lsp.mason.capabilities")
local on_attach = require("lsp.mason.on_attach")
local servers = require("lsp.mason.servers")
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities.capabilities,
			on_attach = on_attach.on_attach,
			settings = servers[server_name],
		})
	end,
})
