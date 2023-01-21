-- See `:help telescope.builtin`


--custom
local vimp = require("vimp")

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
vimp.vnoremap("J", ":m '>+1<CR>gv=gv")
vimp.vnoremap("K", ":m '<-2<CR>gv=gv")
vimp.nnoremap("<C-p>", ":Telescope find_files <CR>")
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

require("which-key").register({
	q = { "lua vim.diagnostic.setloclist()", "Show diagnostics in loclist" },
	A = { "lua vim.diagnostic.open_float()", "Show diagnostics" },
	B = { '<cmd>require("telescope.builtin").buffers<cr>', "[ ] Find existing buffers" },
	e = { "<cmd>NvimTreeToggle<cr>", "Tree" },
	E = { "<cmd>Oil<cr>", "Tree" },
	h = { "<cmd>BufferPrevious<cr>", "Previous buffer" },
	l = { "<cmd>BufferNext<CR>", "Next Buffer" },
	f = {
		name = "file",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		h = { "<cmd>Telescope help tags<cr>", "Help Tags" },
		g = { "<cmd>Telescope live_grep<cr>", "Help Tags" },
		t = { "<cmd>Telescope treesitter<cr>", "Treesitter" },
		e = { "<cmd>Telescope file_browser<cr>", "Telescope File Browser" },
		k = { "<cmd>Telescope keymaps<cr>", "Telescope Keymaps" },
	},
	G = {
		name = "git",
		g = { "<cmd>Neogit<cr>", "Neogit" },
		s = { '<cmd>lua require"gitsigns".stage_hunk()<CR>', "Stage Hunk" },
		u = { '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', "Unstage Hunk" },
		r = { '<cmd>lua require"gitsigns".reset_hunk()<CR>', "Reset Hunk" },
		R = { '<cmd>lua require"gitsigns".reset_buffer()<CR>', "Reset Buffer" },
		p = { '<cmd>lua require"gitsigns".preview_hunk()<CR>', "Preview hunk" },
		b = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', "Blame" },
		S = { '<cmd>lua require"gitsigns".stage_buffer()<CR>', "stage buffer" },
		U = { '<cmd>lua require"gitsigns".reset_buffer_index()<CR>', "Reset Buffer Index" },
	},
	H = { "<cmd>HardTimeToggle<cr>", "Hard time toggle" },
	t = {
		name = "Test",
		a = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "All" },
		d = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>', "All" },
		n = { '<cmd>lua require("neotest").run.run()<cr>', "Nearest" },
		s = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Summary" },
	},
	s = {
		name = "telescope",
		f = { '<cmd>require("telescope.builtin").find_files<cr>', "[S]earch [F]iles" },
		h = { '<cmd>require("telescope.builtin").help_tags<cr>', "[S]earch [H]elp" },
		w = { '<cmd>require("telescope.builtin").grep_string<cr>', "[S]earch current [W]ord" },
		g = { '<cmd>require("telescope.builtin").live_grep<cr>', "[S]earch by [G]rep" },
		d = { '<cmd>require("telescope.builtin").diagnostics<cr>', "[S]earch [D]iagnostics" },
	},
	v = {
		name = "toggle",
		v = {
			function()
				vim.o.relativenumber = not vim.o.relativenumber
			end,
			"Relative Number",
		},
	},
}, { prefix = "<leader>" })
