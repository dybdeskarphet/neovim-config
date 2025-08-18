MiniDeps.add({
	source = "mbbill/undotree",
})

MiniDeps.later(function()
	require("which-key").add({
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Open Undotree" },
	})
end)
