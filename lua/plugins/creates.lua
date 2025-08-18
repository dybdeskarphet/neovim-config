MiniDeps.add({
	source = "saecki/crates.nvim",
	checkout = "stable",
})

MiniDeps.later(function()
	require("crates").setup({
		lsp = {
			enabled = true,
			on_attach = function(client, bufnr) end,
			actions = true,
			completion = true,
			hover = true,
		},
	})
end)
