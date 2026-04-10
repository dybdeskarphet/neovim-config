-- Disable comments on pressing Enter {{{
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Disable annoying auto-commenting on Enter",
})
-- }}}

-- Leaader Key {{{
g.mapleader = " "
g.maplocalleader = ","
-- }}}

-- Tabs  {{{
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
-- }}}

-- Folding {{{
opt.foldlevelstart = 99
-- }}}

-- Clipboard {{{
opt.clipboard = ""
opt.fixeol = false
-- }}}

-- Undo {{{
opt.undofile = true
local undodir = fn.expand("~/.cache/nvim_undo")
if fn.isdirectory(undodir) == 0 then
	fn.mkdir(undodir, "p")
end
opt.undodir = undodir
-- }}}

-- Searching {{{
opt.hlsearch = true
opt.incsearch = true
-- }}}

-- Spellcheck {{{
opt.spelllang = "tr"
-- }}}

-- Search {{{
opt.ignorecase = true
opt.joinspaces = false
opt.smartcase = true
opt.showmatch = true
-- }}}

-- Window {{{
opt.splitbelow = true
opt.splitright = true
-- }}}

-- Wild Menu {{{
opt.wildmenu = true
opt.wildmode = "longest:full,full"
-- }}}

-- Themeing {{{
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
-- }}}

-- <C-a>/<C-x> tweaks {{{
opt.nf = "unsigned,bin,hex"
-- }}}

-- Disable Plugin Maps {{{
g.no_plugin_maps = true
-- }}}

-- Diagnostics {{{
local diag = vim.diagnostic
diag.config({
	underline = { severity = { min = diag.severity.WARN } },
	virtual_text = { severity = { min = diag.severity.ERROR } },
	signs = {
		text = {
			[diag.severity.HINT] = "󰌶",
			[diag.severity.ERROR] = "󰅚",
			[diag.severity.INFO] = "",
			[diag.severity.WARN] = "󰀪",
		},
	},
})
-- }}}

-- Set filetype with extension {{{
vim.filetype.add({
	filename = {
		["todo.txt"] = "todotxt",
		["dunstrc"] = "dosini",
	},
	pattern = {
		[".*%.todo%.txt"] = "todotxt",
		[".*.rasi"] = "rasi",
		[".*/hypr/.*%.conf"] = "hyprlang",
	},
})
-- }}}

-- Disable Built-in Plugins {{{
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"matchit",
}
for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
-- }}}

-- Mappings {{{1
-- Global {{{2
nm("<leader>w", "<c-w>", "Press Ctrl-W")
-- }}}
-- Clipboard {{{2
map({ "v", "n" }, "<leader>p", '<esc>"+p', { noremap = true, desc = "Paste the clipboard after the cursor" })
map({ "v", "n" }, "<leader>P", '<esc>"+P', { noremap = true, desc = "Paste the clipboard before the cursor" })
map({ "v", "n" }, "<leader>y", '"+y', { noremap = true, desc = "Use yank options with system clipboard" })
-- }}}
-- Window Management {{{2
nm("<A-S-l>", "<cmd>wincmd L<cr>", "Move to far right")
nm("<A-S-h>", "<cmd>wincmd H<cr>", "Move to far left")
nm("<A-S-j>", "<cmd>wincmd J<cr>", "Move to far bottom")
nm("<A-S-k>", "<cmd>wincmd K<cr>", "Move to far top")
nm("<A-C-k>", "<cmd>vertical resize +5<cr>", "Increase the width of current window")
nm("<A-C-j>", "<cmd>vertical resize -5<cr>", "Decrease the width of current window")
-- }}}
-- Buffer Movement {{{2
-- nm("<A-l>", "<cmd>bn<cr>", "Focus on the next buffer")
-- nm("<A-h>", "<cmd>bp<cr>", "Focus on the previous buffer")
-- }}}
-- Spellcheck {{{2
nm("<leader>Ss", "<cmd>set spell<cr>", "Enable Turkish spellcheck")
nm("<leader>Su", "<cmd>set nospell<cr>", "Disable Turkish spellcheck")
-- }}}
-- Open terminal {{{2
nm("<leader>T", function()
	cmd.vnew()
	cmd.term()
	cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
end, "Open a terminal window")
tm("<Esc>", "<C-\\><C-n>", "Exit terminal insert mode")
-- }}}
-- Delete a buffer {{{2
nm("<A-q>", require("mini.bufremove").delete, "Delete the buffer")
-- }}}
-- Move visual blocks {{{2
vm("K", ":m '<-2<CR>gv=gv", "Move the visual block up")
vm("J", ":m '>+1<CR>gv=gv", "Move the visual block down")
-- }}}
-- Mappings for convenience {{{2
map("n", "<esc><esc>", ":noh<cr>", { noremap = true, silent = true, desc = "Clear hihglights" })
-- }}}
-- Create splits {{{2
nm("<leader>\\", "<cmd>vsplit<cr>", "Create a vertical split")
nm("<leader>-", "<cmd>split<cr>", "Create a horizontal split")
-- }}}
-- Buffer movement {{{2
nm("<A-l>", "<cmd>bn<cr>", "Focus on the next buffer")
nm("<A-h>", "<cmd>bp<cr>", "Focus on the previous buffer")
-- }}}

-- vim: fdm=marker fdl=0
