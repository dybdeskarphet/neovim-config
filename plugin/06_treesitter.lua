later(function()
	-- Initialize plugins {{{
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				cmd("TSUpdate")
			end,
		},
	})
	add("nvim-treesitter/nvim-treesitter-context")
	add("windwp/nvim-ts-autotag")
	add("nvim-treesitter/nvim-treesitter-textobjects")
	-- }}}

	-- nvim-treesitter {{{
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
		"markdown_inline",
		"csv",
		"html",
		"htmldjango",
		"tsx",
		"sql",
		"c_sharp",
		"todotxt",
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			pcall(vim.treesitter.start)
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
	-- }}}

	-- treesitter-context {{{
	require("treesitter-context").setup({
		enable = true,
		multiwindow = true,
		max_lines = 1,
		min_window_height = 0,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "topline",
		separator = nil,
		zindex = 20,
		on_attach = nil,
	})
	-- }}}

	-- nvim-ts-autotag {{{
	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = true,
		},
	})
	-- }}}

	-- TSCheck command {{{
	vim.api.nvim_create_user_command("TSCheck", function()
		local is_active = tostring(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil)
		notify("Is TS Active: " .. is_active)
	end, {})
	-- }}}

	-- TS Folding {{{
	go.foldmethod = "expr"
	go.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	-- }}}

	-- Trigger Treesitter for already loaded buffers and set up folding {{{
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			if pcall(vim.treesitter.start) then
				if vim.wo.foldmethod == "manual" then
					wo.foldmethod = "expr"
					wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end
			end
		end
	end
	-- }}}
end)

-- vim: fdm=marker fdl=0
