require("neotest").setup({
    quickfix = {
      enabled = true,
      open = false
    },
        adapters = {
                require('neotest-jest')({
                        jestCommand = "npm test --",
                        --jestConfigFile = "custom.jest.config.ts",
                        env = { CI = true },
                        cwd = function(path)
                                return vim.fn.getcwd()
                        end,
                }),
        }
})
