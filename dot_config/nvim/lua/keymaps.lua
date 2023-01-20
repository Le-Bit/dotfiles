-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>B', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


--custom
local vimp = require('vimp')
vimp.vnoremap('J', ":m '>+1<CR>gv=gv")
vimp.vnoremap('K', ":m '<-2<CR>gv=gv")
vimp.nnoremap('<C-p>', ':Telescope find_files <CR>')
vimp.nnoremap('<Leader>l', ':BufferNext<CR>')
vimp.nnoremap('<Leader>h', ':BufferPrevious<CR>')

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

--which key
require("which-key").register({
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code actions" },
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
  d = {
    name = "DAP",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  },
  g = {
    name = "lsp",
    n = { "<cmd>TSLspOrganize<cr>", "Organize" },
    i = { "<cmd>TSLspRenameFile<cr>", "Rename file" },
    o = { "<cmd>TSLspImportAll<cr>", "Import All" },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Formatting" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definitions" },
    y = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "type def" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "refs" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code action" },
  },
  t = {
    name = "Test",
    a = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "All" },
    n = { '<cmd>lua require("neotest").run.run()<cr>', "Nearest" },
    s = {'<cmd>lua require("neotest").summary.toggle()<cr>', "Summary"},
    w = {"<cmd>lua require('neotest').run.run({ jestCommand = 'npm test -- --watch ' })<cr>", "watch"}
  },
  rn = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
--  e = { "<cmd>NvimTreeToggle<cr>", "Tree" },
  v = {
    name = "toggle",
    v = { function() vim.o.relativenumber = not vim.o.relativenumber end, "Relative Number" },
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
}, { prefix = "<leader>" })
