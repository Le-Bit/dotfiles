require'lualine'.setup {
  options = {fmt = string.lower, theme = 'gruvbox'},
  sections = {lualine_a = {
    {'mode', fmt = function(str) return str:sub(1,1) end}},
    lualine_b = {'branch'}}
  }

 --theme
 vim.cmd('hi! Normal ctermbg=NONE guibg=NONE')
 vim.cmd('hi! NonText ctermbg=NONE guibg=NONE')
 vim.g.termguicolors = false
 vim.cmd('set t_8f=[38;2;%lu;%lu;%lum')
 vim.cmd('set t_8b=[48;2;%lu;%lu;%lum')

vim.cmd('colorscheme gruvbox-baby')
vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_keyword_style = "NONE"
