local ls = require("luasnip")
local add_snippets = ls.add_snippets
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local r = require("luasnip.extras").rep
local c = ls.choice_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local l = require("luasnip.extras").lambda

--local d = ls.dynamic_node
--local rep = require("luasnip.extras").rep
local function remove_export(args, parent, user_args)
  return t(args.gsub("exports: [", ""))
end

add_snippets("all", {
  s(
    "mod",
    fmt(
      [[
import  {{ Module }} from '@nestjs/common';
@Module({{
   {}
   imports: [{}],
   providers: [{}], 
}})
export class {}Module {{}}
]]     ,
      {
        c(1, {
          fmt("exports: [{}],", { i(1) }),
          fmt("controllers: [{}],", { i(1) }),
        }),
        i(2),
        l(l._1:gsub('exports: %[(.*)],', "%1"),{1}),
        c(3, {
          t("Api"),
          t("Engine"),
          t("Repository"),
        }),
      }
    )
  ),
}, { key = "all" })
