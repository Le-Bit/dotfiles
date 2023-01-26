--  This function gets run when an LSP connects to a particular buffer.
local M = {}
M.on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local whichkey = require("which-key")
	local keymap_leader = {
		rn = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]e[n]ame" },
		c = { a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[C]ode [A]ction" } },
		D = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type [D]efinition" },
		A = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Show diagnostics in loclist" },
		a = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostics" },
		w = {
			s = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>', '[W]orkspace [S]ymbols" },
			a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "[W]orkspace [A]dd Folder" },
			r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "[W]orkspace [R]emove Folder" },
			l = {
				"function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end<cr>",
				"[W]orkspace [L]ist Folders",
			},
		},
		g = {
			name = "lsp",
			f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Formatting" },
			y = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "type def" },
			r = { "<cmd>lua vim.lsp.buf.references()<cr>", "refs" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
		},
		d = {
			s = {
				'require("telescope.builtin").lsp_document_symbols',
				"[D]ocument [S]ymbols",
			},
		},
	}

	local keymap_noprefix = {
		["<C-k>"] = {
			"<cmd>lua vim.lsp.buf.signature_help()<cr>",
			"Signature Documentation",
		},
		g = {
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "[G]oto [D]efinition" },
			r = { '<cmd>lua require("telescope.builtin").lsp_references()<cr>', "[G]oto [R]eferences" },
			I = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "[G]oto [I]mplementation" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[G]oto [D]eclaration" },
		},
		K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
	}

	whichkey.register(keymap_leader, {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	whichkey.register(keymap_noprefix, {
		mode = "n",
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

return M
