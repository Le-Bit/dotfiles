require('options')
require('mappings')
require('look')
require('plugins')
require('lsp')
require('config.treesitter')
require('config.gitsigns')
require('config.neogit')
require("telescope").load_extension "file_browser"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
