local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("vb", {
    s("If", fmt([[
    If {} Then
        {}
    End If
    ]], {i(1), i(2)})), s("ElseIf", fmt([[
    ElseIf {} Then
        {}
    ]], {i(1), i(2)})), s("Else", fmt([[
    Else
        {}
    ]], {i(1)})), s("Sub", fmt([[
    Sub {}()
        {}
    End Sub
    ]], {i(1), i(2)})), s("Function", fmt([[
    Function {}()
        {}
    End Function
    ]], {i(1), i(2)}))
})

