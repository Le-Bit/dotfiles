if not not vim.g.vscode then
  require('vscode')
else
  require("options")
  require("keymaps")
  require("autocommands")
  require("plugins")
  require("lsp")
  require("languages.typescript")
  require("testing")
end
