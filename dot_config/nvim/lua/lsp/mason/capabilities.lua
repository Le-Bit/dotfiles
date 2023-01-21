-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--
local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
return M
