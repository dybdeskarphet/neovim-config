return {
	"sschleemilch/slimline.nvim",
	opts = {
		bold = true,
		style = "fg",
		spaces = {
			components = "",
			left = "",
			right = "",
		},
		configs = {
			mode = {
				verbose = true,
				bold,
			},
		},
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "SlimlineModeNormal", { bg = "#222222", fg = "#c8bfff" })
		require("slimline").setup(opts)
	end,
}
