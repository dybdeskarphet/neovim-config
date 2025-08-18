require("helpers.mini")

local update_treesitter = function()
	vim.cmd("TSUpdate")
end

add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_install = update_treesitter,
		post_checkout = update_treesitter,
	},
})

add({
	source = "nvim-treesitter/nvim-treesitter-context",
})

add({
	source = "windwp/nvim-ts-autotag",
})

later(function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"lua",
			"typescript",
			"javascript",
			"python",
			"rust",
			"hyprlang",
			"latex",
			"markdown",
			"csv",
			"html",
			"htmldjango",
			"tsx",
			"sql",
			"c_sharp",
		},
		sync_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	})

	-- For Hyprland configs
	vim.filetype.add({ pattern = { [".*/hypr/.*%.conf"] = "hyprlang" } })

	require("treesitter-context").setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		multiwindow = true, -- Enable multiwindow support.
		max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 20, -- Maximum number of lines to show for a single context
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	})

	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = true,
		},
	})
end)
