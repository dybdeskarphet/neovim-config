require("helpers.keyboard")
local lsp = vim.lsp

nm("grh", function()
	lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
end, "Enable inlay hints")

nm("K", function()
	lsp.buf.hover()
end, "Hover information")

nm("gra", function()
	lsp.buf.code_action()
end, "Code action")

nm("grn", function()
	lsp.buf.rename()
end, "Rename symbol")

nm("grr", function()
	MiniExtra.pickers.lsp({ scope = "references" })
end, "List references")

nm("gd", function()
	lsp.buf.definition()
end, "Go to definition")

nm("gD", function()
	lsp.buf.declaration()
end, "Goto Declaration")
