local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {}
  if server.name == "tsserver" then
    opts.root_dir = function() 
      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
          local ts_utils = require("nvim-lsp-ts-utils")
          ts_utils.setup({
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = true,
            eslint_enable_code_actions = true,
            enable_formatting = true,
            formatter = "prettier",
          })
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          ts_utils.setup_client(client)
          require('mappings').ts_on_attach(client, bufnr)
          require('mappings').on_attach(client, bufnr)
        end,
      })

    end
  end
  server:setup(opts)
end)
