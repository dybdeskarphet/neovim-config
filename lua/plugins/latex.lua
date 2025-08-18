MiniDeps.add({
	source = "lervag/vimtex",
})

MiniDeps.later(function()
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_compiler_method = "latexrun"
	require("which-key").add({
		{
			"<leader>L",
			"<cmd>VimtexCompile<CR>",
			desc = "Compile the current TeX file",
		},
	})
end)
