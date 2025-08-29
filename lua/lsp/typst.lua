vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		semanticTokens = "disable",
	},
})
