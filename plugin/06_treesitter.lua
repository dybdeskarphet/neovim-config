later(function()
	-- Initialize plugins {{{1
	add({
		gh("nvim-treesitter/nvim-treesitter"),
		gh("nvim-treesitter/nvim-treesitter-context"),
		gh("windwp/nvim-ts-autotag"),
		gh("nvim-treesitter/nvim-treesitter-textobjects"),
	})
	-- Treesitter hook {{{2
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "nvim-treesitter" and kind == "update" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
			end
		end,
	})
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
