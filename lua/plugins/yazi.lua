MiniDeps.add({
	source = "mikavilpas/yazi.nvim",
	depends = { "nvim-lua/plenary.nvim" },
})

MiniDeps.later(function()
	vim.api.nvim_set_hl(0, "YaziFloat", { link = "NormalFloat" })
	require("yazi").setup({
		open_for_directories = false,
		keymaps = { show_help = "<f1>" },
		yazi_floating_window_border = "none",
	})
	require("which-key").add({
		{ "T", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
		{
			-- Open in the current working directory
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
	})
end)
