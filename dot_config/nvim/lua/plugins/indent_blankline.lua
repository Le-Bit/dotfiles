vim.cmd([[highlight IndentBlanklineIndent1 guibg=#24283b gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1f2335 gui=nocombine]])
-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({

	char = "",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
	},
	space_char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
	},
	show_trailing_blankline_indent = false,
})
