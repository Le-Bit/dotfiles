require("neotest").setup({
	quickfix = {
		enabled = false,
		open = false,
	},
	adapters = {
		require("neotest-jest")({
			jestCommand = "npm test --",
			env = { CI = true },
			cwd = function()
				return vim.fn.getcwd()
			end,
		}),
	},
})
