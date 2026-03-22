-- Initialize plugins {{{
add("lervag/vimtex")
add("phrmendes/todotxt.nvim")
-- }}}

-- vimtex {{{
g.vimtex_view_method = "zathura"
g.vimtex_view_general_viewer = "zathura"
g.vimtex_compiler_method = "latexrun"
-- }}}

-- todotxt.nvim {{{
require("todotxt").setup({
	todotxt = vim.env.HOME .. "/doc/current.todo.txt",
	donetxt = vim.env.HOME .. "/doc/done.todo.txt",
	ghost_text = {
		enable = true,
		mappings = {
			["(A)"] = "urgent, important",
			["(B)"] = "urgent, not important",
			["(C)"] = "not urgent, important",
			["(D)"] = "not urgent, not important",
		},
	},
})
-- }}}

-- vim: fdm=marker fdl=0
