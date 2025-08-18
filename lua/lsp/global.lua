require("which-key").add({
	{ "<leader>l", group = "LSP", desc = "" },
	{
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<CR>",
		desc = "Code action",
	},
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
	{
		"<leader>lx",
		function()
			MiniExtra.pickers.diagnostic()
		end,
		desc = "Search diagnostics",
	},
	{ "K", vim.lsp.buf.hover(), desc = "Hover information" },
	{
		"gd",
		function()
			vim.lsp.buf.definition()
		end,
		desc = "Go to definition",
	},
	{
		"<leader>gr",
		function()
			MiniExtra.pickers.lsp({ scope = "references" })
		end,
		desc = "List references",
	},
	{
		"gD",
		function()
			vim.lsp.buf.declaration()
		end,
		desc = "Goto Declaration",
	},
})
