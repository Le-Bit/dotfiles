-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

require("telescope").load_extension("file_browser")

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")
