local update_treesitter = function()
	cmd("TSUpdate")
end

add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = {
		post_install = update_treesitter,
		post_checkout = update_treesitter,
	},
})
add({ source = "nvim-treesitter/nvim-treesitter-context" })
add({ source = "windwp/nvim-ts-autotag" })
add({ source = "nvim-treesitter/nvim-treesitter-textobjects" })

now(function()
	local treesitter = require("nvim-treesitter")
	treesitter.install({
		"lua",
		"toml",
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
		"todotxt",
	})

	require("treesitter-context").setup({
		enable = true,
		multiwindow = true,
		max_lines = 1,
		min_window_height = 0,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "topline",
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20,
		on_attach = nil,
	})

	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = true,
		},
	})

	vim.api.nvim_create_user_command("TSCheck", function()
		local is_active = tostring(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil)
		vim.notify("Is TS Active: " .. is_active)
	end, {})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			pcall(vim.treesitter.start)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
end)
