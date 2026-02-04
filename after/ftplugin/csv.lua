add({
	source = "hat0uma/csvview.nvim",
})

later(function()
	require("csvview").setup({
		view = {
			---@type "highlight" | "border"
			display_mode = "highlight",
		},
	})
end)
