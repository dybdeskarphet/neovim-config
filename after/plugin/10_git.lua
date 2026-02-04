add({
	source = "kdheepak/lazygit.nvim",
	depends = { "nvim-lua/plenary.nvim" },
})

later(function()
	require("mini.diff").setup({
		view = {
			--- @type 'sign' | 'number'.
			style = "number",
			signs = { add = "┃", change = "┃", delete = "_" },
			priority = 199,
		},

		source = nil,
		delay = {
			text_change = 200,
		},

		mappings = {
			apply = "gh",
			reset = "gH",
			textgbject = "gh",
			goto_first = "[H",
			goto_prev = "[h",
			goto_next = "]h",
			goto_last = "]H",
		},

		options = {
			algorithm = "histogram",
			indent_heuristic = true,
			linematch = 60,
			wrap_goto = false,
		},
	})
	require("mini.git").setup()
	nm("<leader>G", "<cmd>LazyGit<cr>", "Open LazyGit")
end)
