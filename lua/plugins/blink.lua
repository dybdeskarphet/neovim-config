return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"bydlw98/blink-cmp-env",
		"moyiz/blink-emoji.nvim",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = "1.*",
	build = "cargo +nightly build --release",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
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
		snippets = { preset = "luasnip" },
		sources = {
			-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
			default = { "snippets", "lsp", "path", "buffer", "env", "emoji" },
			providers = {
				env = {
					name = "Env",
					module = "blink-cmp-env",
					--- @type blink-cmp-env.Options
					opts = {
						show_braces = false,
						show_documentation_window = true,
					},
					should_show_items = function()
						return vim.tbl_contains( -- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ "sh" },
							vim.o.filetype
						)
					end,
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- Tune by preference
					opts = { insert = true }, -- Insert emoji (default) or complete its name
					should_show_items = function()
						return vim.tbl_contains( -- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ "gitcommit", "markdown", "text" },
							vim.o.filetype
						)
					end,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		appearance = { nerd_font_variant = "mono" },
		completion = {
			keyword = { range = "prefix" },
			accept = { auto_brackets = { enabled = false } },
			ghost_text = { enabled = false },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = { border = "single" },
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
								local lspkind = require("lspkind")
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
