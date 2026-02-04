add({ source = "phrmendes/todotxt.nvim" })
later(function()
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
end)
