add({
	source = "lervag/vimtex",
})

later(function()
	g.vimtex_view_method = "zathura"
	g.vimtex_view_general_viewer = "zathura"
	g.vimtex_compiler_method = "latexrun"
end)
