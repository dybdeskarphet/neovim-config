later(function()
	require("mini.comment").setup()
	require("mini.ai").setup()
	require("mini.surround").setup()
	require("mini.pairs").setup()
	require("mini.icons").setup()
	require("mini.icons").mock_nvim_web_devicons()
	require("mini.pick").setup()
	require("mini.cursorword").setup()
	require("mini.notify").setup({
		content = {
			format = nil,
			sort = nil,
		},
		lsp_progress = {
			enable = true,
			level = "ERROR",
			duration_last = 1000,
		},
		window = {
			config = {
				border = "none",
				anchor = "NE",
			},
			max_width_share = 0.382,
			winblend = 25,
		},
	})
	vim.notify = require("mini.notify").make_notify()
	require("mini.bufremove").setup()
	require("mini.trailspace").setup()

	set_highlights({
		MiniNotifyTitle = { fg = "#f9f5d7", bg = "none" },
		MiniNotifyLspProgress = { fg = "#f9f5d7", bg = "none" },
		MiniNotifyNormal = { fg = "#f9f5d7", bg = "none" },
	})
end)
