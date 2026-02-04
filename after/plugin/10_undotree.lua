add({
	source = "mbbill/undotree",
})

later(function()
	nm("<leader>u", "<cmd>UndotreeToggle<cr>", "Show the Undo tree")
end)
