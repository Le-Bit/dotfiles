-- See `:help telescope.builtin`

local whichkey = require("which-key")

local no_leader_keymap = {
	["<C-p>"] = {
		"<cmd>lua require('telescope.builtin').find_files()<cr>",
		"find_files",
	},
	["<C-i>"] = {"<cmd><Plug>(TaboutMulti)<cr>"},
	["<C-o>"] = {"<cmd><Plug>(TaboutBackMulti)<cr>"},
	["]"] = {
		d = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "previous diagnostic" },
	},
	["["] = {
		d = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "next diagnostic" },
	},
}

whichkey.register(no_leader_keymap, {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

local visual_keymap = {
	J = {
		":m '>+1<CR>gv=gv<CR>",
		"down selection",
	},
	K = {
		":m '<-2<CR>gv=gv<CR>",
		"down selection",
	},
	r = {
		"<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
		"refactor code action",
	},
}

whichkey.register(visual_keymap, {
	mode = "v",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})

whichkey.register({
	["/"] = {
		'<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false, }))<cr>',
		"fuzzily search in buffer",
	},
	["?"] = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "[?] Find recently opened files" },
	B = { '<cmd>require("telescope.builtin").buffers<cr>', "[ ] Find existing buffers" },
	e = { "<cmd>NvimTreeToggle<cr>", "Tree" },
	E = { "<cmd>Oil<cr>", "Tree" },
	h = { "<cmd>BufferPrevious<cr>", "Previous buffer" },
	l = { "<cmd>BufferNext<CR>", "Next Buffer" },
	T = { "<cmd>TroubleToggle<CR>"},
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
		f = { '<cmd>lua require("telescope.builtin").find_files()<CR>', "[S]earch [F]iles" },
		h = { '<cmd>lua require("telescope.builtin").help_tags()<CR>', "[S]earch [H]elp" },
		w = { '<cmd>lua require("telescope.builtin").grep_string()<CR>', "[S]earch current [W]ord" },
		g = { '<cmd>lua require("telescope.builtin").live_grep()<CR>', "[S]earch by [G]rep" },
		d = { '<cmd>lua require("telescope.builtin").diagnostics()<CR>', "[S]earch [D]iagnostics" },
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
