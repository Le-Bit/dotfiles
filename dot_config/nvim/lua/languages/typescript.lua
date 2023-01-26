local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "relative",
				importModuleSpecifier = "relative",
			},
		},
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		settings = { documentFormatting = false },
		initOptions = {
			preferences = {
				importModuleSpecifierPreference = "project-relative",
				importModuleSpecifier = "project-relative",
			},
		},
		handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
			}),
		},
		on_attach = function(client, bufnr)
			local whichkey = require("which-key")
			local keymaps = {
				g = {
					n = { "<cmd>:TypescriptOrganizeImports<cr>", "organiz imports" },
					i = { "<cmd>:TypescriptRenameFile<cr>", "rename file" },
					o = { "<cmd>:TypescriptAddMissingImports<cr>", "add missing imports" },
					f = { "<cmd>:EslintFixAll<cr>", "eslint fix all" },
					F = { "<cmd>:TypescriptFixAll<cr>", "typescript fix all" },
				},
			}
			whichkey.register(keymaps, {
				mode = "n",
				prefix = "<leader>",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = false,
			})

			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", { command = "EslintFixAll" })
			end
		end,
	},
})
