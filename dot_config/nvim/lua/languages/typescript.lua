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
			vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
			vim.cmd("command! LspFormatting lua vim.lsp.buf.format({async = true})")
			vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
			vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
			vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
			vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
			vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
			vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
			vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
			vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
			vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
			vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
			keymaps = {
				g = {
				n = {'<cmd>:TypescriptOrganizeImports<cr>','organiz imports'},
				i = {'<cmd>:TypescriptRenameFile<cr>','rename file'},
				o = {'<cmd>:TypescriptAddMissingImports<cr>', 'add missing imports'},
				f = {'<cmd>:EslintFixAll<cr>', 'eslint fix all'},
				d = {'<cmd>LspDef<cr>', 'lsp definition'},
				},
				a = {'<cmd><cr>', 'lsp diag line'}
			}
			whichkey.register(keymaps, {
				mode = "n",
				prefix = "<leader>",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = false,
			})
			local keymaps_no_leader = {
				g = {
					y = {'<cmd>:LspTypeDef<cr>','organiz imports'},
					a = {'<cmd>:LspCodeAction<cr>','organiz imports'},
				},
				K = {':LspHover<CR>', 'lsp hover'},

			}
			whichkey.register(keymaps_no_leader, {
				mode = "n",
				prefix = "",
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = false,
			})

			buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
			buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
			buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", { command = "EslintFixAll" })
			end
		end,
	},
})
