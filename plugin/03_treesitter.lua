-- Initialize plugins {{{
add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("windwp/nvim-ts-autotag"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
})
-- }}}

-- nvim-treesitter {{{
local ts = require("nvim-treesitter")

ts.setup()

ts.install({
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
	"nix",
	"tsx",
	"sql",
	"c_sharp",
	"todotxt",
})
-- }}}

-- treesitter indentation {{{
local disabled_indent_filetypes = { "typescriptreact", "javascriptreact" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		pcall(vim.treesitter.start)
		local ft = vim.bo[args.buf].filetype
		if not vim.tbl_contains(disabled_indent_filetypes, ft) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
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

-- vim: fdm=marker fdl=0
