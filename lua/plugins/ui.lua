require("helpers.mini")

add({
	source = "loctvl842/monokai-pro.nvim",
})

add({
	source = "shellRaining/hlchunk.nvim",
})

add({
	source = "OXY2DEV/foldtext.nvim",
})

now(function()
	require("monokai-pro").setup({
		transparent_background = false,
		devicons = true,
		styles = {
			comment = { italic = true },
			keyword = { italic = true }, -- any other keyword
			type = { italic = true }, -- (preferred) int, long, char, etc
			storageclass = { italic = true }, -- static, register, volatile, etc
			structure = { italic = true }, -- struct, union, enum, etc
			parameter = { italic = true }, -- parameter pass in function
			annotation = { italic = true },
			tag_attribute = { italic = true }, -- attribute of tag in reactjs
		},
		filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
	})
	vim.cmd([[colorscheme monokai-pro-spectrum]])

	vim.api.nvim_set_hl(0, "MiniStarterHeader", { bg = "none", fg = "#c8bfff", bold = true })
	vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { bg = "none", fg = "#c8bfff", bold = true })
	local starter = require("mini.starter")

	starter.setup({
		autoopen = true,
		evaluate_single = true,
		items = {
			starter.sections.builtin_actions(),
			starter.sections.recent_files(10, true, true),
		},

		header = [[ ▌  ▌  ▌    ▌       ▌   ▗ 
▛▌▌▌▛▌▛▌█▌▛▘▙▘▀▌▛▘▛▌▛▌█▌▜▘
▙▌▙▌▙▌▙▌▙▖▄▌▛▖█▌▌ ▙▌▌▌▙▖▐▖
  ▄▌              ▌       ]],
		footer = [[]],
		content_hooks = {
			starter.gen_hook.indexing("all", { "Builtin actions" }),
			starter.gen_hook.aligning("center", "center"),
		},
		query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
		silent = true,
	})

	vim.api.nvim_set_hl(0, "MiniStatusLineModeNormal", { bg = "#222222", fg = "#c8bfff", bold = true })
	vim.api.nvim_set_hl(0, "MiniStatusLineModeInsert", { bg = "#222222", fg = "#fce566", bold = true })
	vim.api.nvim_set_hl(0, "MiniStatusLineModeCommand", { bg = "#222222", fg = "#fc618d", bold = true })
	vim.api.nvim_set_hl(0, "MiniStatusLineModeVisual", { bg = "#222222", fg = "#5ad4e6", bold = true })
	vim.api.nvim_set_hl(0, "MiniStatusLineModeOther", { bg = "#222222", fg = "#f7f1ff", bold = true })

	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#222222", fg = "#f7f1ff", bold = false })
	local hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
	hl.bg = "#222222"
	vim.api.nvim_set_hl(0, "StatusLine", hl)

	require("mini.statusline").setup({
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics()
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
		inactive = {},
	})

	local hl = vim.api.nvim_get_hl(0, { name = "MiniTablineCurrent" })
	hl.fg = "#c8bfff"
	vim.api.nvim_set_hl(0, "MiniTablineCurrent", hl)
	require("mini.tabline").setup({

		show_icons = true,
		format = function(buf_id, label)
			local suffix = vim.bo[buf_id].modified and "+ " or ""
			return MiniTabline.default_format(buf_id, label) .. suffix
		end,
		tabpage_section = "left",
	})

	local hi_words = require("mini.extra").gen_highlighter.words
	require("mini.hipatterns").setup({
		highlighters = {
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
		},
	})

	require("hlchunk").setup({
		indent = {
			enable = true,
			delay = 50,
		},
		chunk = {
			enable = true,
			delay = 50,
		},
	})

	vim.api.nvim_set_hl(0, "HLChunk1", { bg = "#222222", fg = "#FD9353" })
	vim.api.nvim_set_hl(0, "HLChunk2", { bg = "#222222", fg = "#FD9353" })

	require("foldtext").setup()
end)
