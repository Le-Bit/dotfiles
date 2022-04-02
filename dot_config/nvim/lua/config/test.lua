local M = {}

local keymap = vim.api.nvim_set_keymap

local function keymaps()
  local opts = { noremap = false, silent = true }
  keymap("n", "[t", "<Plug>(ultest-prev-fail)", opts)
  keymap("n", "]t", "<Plug>(ultest-next-fail)", opts)
end

local function config_test()
  vim.api.nvim_exec(
  [[
  " Test config
  let test#strategy = "neovim"
  let test#neovim#term_position = "belowright"
  let g:test#preserve_screen = 1
  let g:ultest_use_pty = 1
  " Javascript
  let g:test#javascript#runner = 'jest'
  ]],
  false
  )
end

local function config_ultest()
  require("ultest").setup { }
end

function M.setup()
  config_test()
  config_ultest()
  keymaps()
end

return M
