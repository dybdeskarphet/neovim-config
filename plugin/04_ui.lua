-- Initialize plugins {{{
-- add("dybdeskarphet/gruvbox-minimal.nvim")
opt.rtp:prepend("~/code/git/gruvbox-minimal.nvim/")
-- }}}

-- mini.starter {{{
local starter = require("mini.starter")
starter.setup({
	autoopen = true,
	evaluate_single = true,
	items = {
		starter.sections.builtin_actions(),
		starter.sections.recent_files(10, true, true),
	},

	header = [[                            ▄
    █     ▄▄█   ▄▀█▄       ▄▀              ▄█
█   █  ▄▄▀  ▀  █▀ █ ▀▄ █   █   ▀█▀▀   █▄  ▄▀█
█▀▄  █   █▀  █ █     █  █ ▄▀    █     █ ▀█  █
▀  ▀▄█ ▄█▄▄▀▀▀  ▀▄▄▄▀    ▀█   ▄▄█▀▀▀▀  █   █
     ▀                    ▀            ▀]],
	footer = [[]],
	content_hooks = {
		starter.gen_hook.indexing("all", { "Builtin actions" }),
		starter.gen_hook.aligning("center", "center"),
	},
	query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",
	silent = true,
})
-- }}}

-- mini.tabline {{{
require("mini.tabline").setup({
	show_icons = true,
	format = function(buf_id, label)
		local suffix = vim.bo[buf_id].modified and " " or " "
		local prefix = (function(buf_id)
			return buf_id == vim.api.nvim_get_current_buf() and "▎" or "▏"
		end)(buf_id)
		return prefix .. MiniTabline.default_format(buf_id, label) .. suffix
	end,
	tabpage_section = "left",
})
-- }}}

-- mini.statusline {{{
local diag_signs = {
	HINT = "%#DiagnosticHint#󰌶 ",
	ERROR = "%#DiagnosticError#󰅚 ",
	INFO = "%#DiagnosticInfo# ",
	WARN = "%#DiagnosticWarn#󰀪 ",
}

local active_statusline_content = function()
	local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
	local git = MiniStatusline.section_git({ trunc_width = 40 })
	local diff = MiniStatusline.section_diff({ trunc_width = 75 })
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, signs = diag_signs })
	diagnostics = diagnostics .. "%#MiniStatuslineDevinfo#"
	local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
	local filename = MiniStatusline.section_filename({ trunc_width = 140 })
	local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
	-- local location = ' %l/%L │  %c/%{virtcol("$")-1}'
	local location = MiniStatusline.section_location({ trunc_width = 75 })
	local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

	return MiniStatusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { diagnostics, git, diff } },
		"%<", -- Mark general truncate point
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=", -- End left alignment
		{ hl = "MiniStatuslineFileinfo", strings = { lsp, fileinfo } },
		{ hl = mode_hl, strings = { search, location } },
	})
end
require("mini.statusline").setup({
	content = {
		active = active_statusline_content,
	},
})
-- }}}

-- gruvbox-minimal.nvim {{{
gruvbox_config = {
	transparent = true,
}
require("gruvbox-minimal").setup(gruvbox_config)
cmd.colorscheme("gruvbox-minimal")
nm("<leader>R", function()
	for name, _ in pairs(package.loaded) do
		if name:match("gruvbox%-minimal") then
			package.loaded[name] = nil
		end
	end
	require("gruvbox-minimal").setup(gruvbox_config)
	cmd.colorscheme("gruvbox-minimal")
	notify("Gruvbox Minimal reloaded.")
end, "Reload gruvbox-minimal.nvim")
-- }}}

-- ui2 {{{
-- opt.cmdheight = 0
require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
			timeout = 5000,
		},
		pager = {
			height = 0.5,
		},
	},
})
-- }}}

-- Run later {{{1
later(function()
	-- mini.indent {{{2
	require("mini.indentscope").setup({
		symbol = "│",
		options = {
			border = "both",
		},
	})
	-- }}}

	-- mini.cursorword + mini.trailspace {{{
	require("mini.cursorword").setup()
	require("mini.trailspace").setup()
	-- }}}

	-- mini.hipatterns {{{
	local hi_words = require("mini.extra").gen_highlighter.words
	require("mini.hipatterns").setup({
		highlighters = {
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
			due_date = {
				pattern = "due:%d%d%d%d%-%d%d%-%d%d",
				group = function(_, match)
					local today = os.date("%Y-%m-%d")
					local today_ts = toEpoch(today)
					local match_ts = toEpoch(match:match("due:(%d%d%d%d%-%d%d%-%d%d)"))

					if match == "due:" .. today then
						return "MiniHipatternsDueToday"
					elseif match_ts < today_ts then
						return "MiniHipatternsDueLate"
					else
						return "MiniHipatternsDueGeneral"
					end
				end,
			},
		},
	})
	-- }}}
end)
-- }}}

-- vim: fdm=marker fdl=0
