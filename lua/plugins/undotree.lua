require("helpers.keyboard")
MiniDeps.add({
	source = "mbbill/undotree",
})

MiniDeps.later(function()
	nm("<leader>u", "<cmd>UndotreeToggle<cr>", "Show the Undo tree")
end)
