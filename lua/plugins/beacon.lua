MiniDeps.add({
	source = "danilamihailov/beacon.nvim",
})

MiniDeps.later(function()
	require("beacon").setup({
		highlight = { bg = "#c8bfff" },
		fps = 100,
	})
end)
