-- Native Completion Settings {{{
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess:append("c")
vim.opt.pumheight = 10
--}}}

-- mini.snippets {{{
local minisnip = require("mini.snippets")
minisnip.setup({
	snippets = {
		minisnip.gen_loader.from_lang(),
		minisnip.gen_loader.from_file("~/.config/nvim/snippets/global.json"),
	},
	mappings = {
		expand = "",
		jump_next = "<Tab>",
		jump_prev = "<S-Tab>",
		stop = "<Esc>",
	},
})
minisnip.start_lsp_server()
-- }}}

-- Plugin setup {{{
local comp = require("mini.completion")
comp.setup({
	delay = { completion = 0, info = 0, signature = 0 },
	window = {
		info = { height = 25, width = 20, border = nil },
		signature = { height = 25, width = 20, border = nil },
	},
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = true,
		process_items = function(items, base)
			return comp.default_process_items(items, base, {
				filtersort = "fuzzy",
				kind_priority = { Snippet = 101 },
			})
		end,
		snippet_insert = nil,
	},
	mappings = {
		force_twostep = "<A-Space>",
		force_fallback = "<C-Space>",
		scroll_down = "<C-b>",
		scroll_up = "<C-f>",
	},
	fallback_action = "<C-x><C-f>",
})
-- }}}

-- mini.pairs (needed because mappings) {{{
require("mini.pairs").setup()
-- }}}

-- Mappings {{{
local km = require("mini.keymap")
km.map_multistep("i", "<C-j>", { "pmenu_next" })
km.map_multistep("i", "<C-k>", { "pmenu_prev" })
km.map_multistep("i", "<BS>", { "minipairs_bs" })
im("<C-f>", "<C-x><C-f>", "Open path completion menu")
map("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		if vim.fn.complete_info().mode == "files" then
			return "<C-y><C-x><C-f>"
		end
		return "<C-y>"
	end
	return require("mini.pairs").cr()
end, { expr = true, replace_keycodes = true, desc = "Accept completion" })
-- }}}

-- vim: fdm=marker fdl=0
