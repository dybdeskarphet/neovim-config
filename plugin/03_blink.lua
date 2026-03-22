-- Initialize plugins {{{
add({
	source = "saghen/blink.cmp",
	depends = {
		"rafamadriz/friendly-snippets",
		"bydlw98/blink-cmp-env",
	},
	checkout = "v1.9.1",
})
-- }}}

-- mini.icons {{{
local icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()
icons.tweak_lsp_kind()
-- }}}

-- mini.pairs {{{
require("mini.pairs").setup()
-- }}}

-- blink.cmp {{{
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<S-Tab>"] = { "snippet_forward", "fallback" },
		["<Tab>"] = { "fallback" },
	},
	sources = {
		default = { "snippets", "lsp", "path", "buffer", "env" },
		providers = {
			env = {
				name = "Env",
				module = "blink-cmp-env",
				opts = {
					show_braces = false,
					show_documentation_window = true,
				},
				should_show_items = function()
					return vim.tbl_contains({ "sh", "fish" }, vim.o.filetype)
				end,
			},
			snippets = {
				opts = {
					friendly_snippets = true,
					extended_filetypes = {
						markdown = { "jekyll" },
						sh = { "shelldoc" },
						php = { "phpdoc" },
						cpp = { "unreal" },
					},
				},
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	appearance = { nerd_font_variant = "mono" },
	completion = {
		keyword = { range = "prefix" },
		accept = { auto_brackets = { enabled = false } },
		ghost_text = { enabled = true },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
			window = { border = "single" },
			treesitter_highlighting = true,
		},
		menu = {
			draw = {
				columns = {
					{ "label", "label_description" },
					{ "kind_icon", gap = 1, "kind" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = icons.get("lsp", ctx.kind)
							return kind_icon
						end,
						highlight = function(ctx)
							local _, hl, _ = icons.get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						highlight = function(ctx)
							local _, hl, _ = icons.get("lsp", ctx.kind)
							return hl
						end,
					},
				},
			},
			auto_show = true,
			auto_show_delay_ms = 0,
		},
	},
})
-- }}}

-- vim: fdm=marker fdl=0
