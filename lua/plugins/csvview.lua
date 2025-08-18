MiniDeps.add({
	source = "hat0uma/csvview.nvim",
	opts = {},
})

MiniDeps.later(function()
	require("csvview").setup({
		view = {
			---@type "highlight" | "border"
			display_mode = "border",
		},
	})
end)
