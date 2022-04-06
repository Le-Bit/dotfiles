vim.g.mapleader = ' '

local vimp = require('vimp')

vimp.vnoremap('J', ":m '>+1<CR>gv=gv")
vimp.vnoremap('K', ":m '<-2<CR>gv=gv")
vimp.nnoremap('<C-p>', ':Telescope find_files <CR>')
vimp.nnoremap('<Leader>l',':BufferNext<CR>')
vimp.nnoremap('<Leader>h',':BufferPrevious<CR>')
vim.cmd("nmap <leader>s <Plug>(easymotion-overwin-f)")

local wk = require("which-key")
wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    b = {"<cmd>Telescope buffers<cr>", "Buffers" },
    h = {"<cmd>Telescope help tags<cr>", "Help Tags" },
    t = {"<cmd>Telescope treesitter<cr>", "Treesitter" },
    e = {"<cmd>Telescope file_browser<cr>", "Telescope File Browser" },
  },
  g = {
    name = "lsp",
    n = {"<cmd>TSLspOrganize<cr>", "Organize" },
    i = {"<cmd>TSLspRenameFile<cr>", "Rename file" },
    o = {"<cmd>TSLspImportAll<cr>", "Import All" },
    f = { "<cmd>LspFormatting<cr>", "Formatting" },
    d = { "<cmd>LspDef<cr>", "Go to Definitions" },
    y = { "<cmd>LspTypeDef<cr>", "type def" },
    a = { "<cmd>LspCodeAction<cr>", "code action" },
  },
  t = {
    name = "Test",
    S = { "<cmd>UltestSummary<cr>", "Summary" },
    a = { "<cmd>Ultest<cr>", "All" },
    d = { "<cmd>UltestDebug<cr>", "Debug" },
    f = { "<cmd>TestFile<cr>", "File" },
    l = { "<cmd>TestLast<cr>", "Last" },
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    o = { "<cmd>UltestOutput<cr>", "Output" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
    v = { "<cmd>TestVisit<cr>", "Visit" },
  },
  rn = { "<cmd>LspRename<cr>", "Rename" },
  e = {"<cmd>NvimTreeToggle<cr>", "Tree"},
  v = {
    name = "toggle",
    v = { function() vim.o.relativenumber = not vim.o.relativenumber end, "Relative Number" },
  },
  G = {
    name = "git",
    g = { "<cmd>Neogit<cr>", "Neogit" },
    s = {'<cmd>lua require"gitsigns".stage_hunk()<CR>', "Stage Hunk" },
    u = {'<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', "Unstage Hunk" },
    r = {'<cmd>lua require"gitsigns".reset_hunk()<CR>', "Reset Hunk" },
    R = {'<cmd>lua require"gitsigns".reset_buffer()<CR>', "Reset Buffer" },
    p = {'<cmd>lua require"gitsigns".preview_hunk()<CR>', "Preview hunk" },
    b = {'<cmd>lua require"gitsigns".blame_line{full=true}<CR>', "Blame" },
    S = {'<cmd>lua require"gitsigns".stage_buffer()<CR>', "stage buffer" },
    U = {'<cmd>lua require"gitsigns".reset_buffer_index()<CR>', "Reset Buffer Index" },
  },
}, { prefix = "<leader>" })

local M = {}

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

M.ts_on_attach = function (client, bufnr)
  buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
  buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
  buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
  buf_map(bufnr, "n", "gf", ":LspFormatting<CR>")
end

M.on_attach = function (client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  buf_map(bufnr, "n", "<leader>ld", ":LspDef<CR>")
  buf_map(bufnr, "n", "rn", ":LspRename<CR>")
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  buf_map(bufnr, "n", "K", ":LspHover<CR>")
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "la", ":LspCodeAction<CR>")
  buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")    
  if client.resolved_capabilities.document_formatting then
    buf_map(bufnr, "n", "<Leader>ff", ":LspFormatting<CR>")
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local cmp = require'cmp'
M.cmp_mappings = {
  ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  -- ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  -- ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
  -- ['<C-Space>'] = cmp.mapping.complete(),
  -- ['<C-e>'] = cmp.mapping.close(),
  -- ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
}

M.gitsigns_mappings = {
  noremap = true,
  ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
  ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
  ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
  ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
}
return M

