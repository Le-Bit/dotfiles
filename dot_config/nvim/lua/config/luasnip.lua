local ls = require 'luasnip'

vim.keymap.set({"i", "s"}, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "-- this is what expanded!");
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend");
    }
  }

