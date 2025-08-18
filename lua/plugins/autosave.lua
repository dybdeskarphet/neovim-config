MiniDeps.add({
	source = "https://git.sr.ht/~nedia/auto-save.nvim",
})

MiniDeps.later(function()
	require("auto-save").setup({
		events = { "InsertLeave", "BufLeave" },
		silent = false,
		-- exclude_ft = {},
	})
end)
