require("neotest").setup({
   quickfix = {
     enabled = true,
     open = true
   },
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})
