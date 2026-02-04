add({ source = "danilamihailov/beacon.nvim" })

later(function()
	require("beacon").setup({
		highlight = { bg = Matugen.palette.primary },
		fps = 100,
	})
end)
