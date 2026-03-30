later(function()
	-- Initialize plugins {{{
	add({ gh("Vigemus/iron.nvim") })
	-- }}}

	-- iron.nvim {{{
	local iron = require("iron.core")
	local view = require("iron.view")
	local common = require("iron.fts.common")

	iron.setup({
		config = {
			scratch_repl = true,
			repl_definition = {
				python = {
					-- I'm generally using python in a .venv created by uv
					command = { "uv", "run", "ipython", "--no-autoindent" },
					format = common.bracketed_paste_python,
					block_dividers = { "# %%", "#%%" },
					env = { PYTHON_BASIC_REPL = "1" },
				},
			},

			repl_filetype = function(bufnr, ft)
				return ft
			end,

			dap_integration = true,

			repl_open_cmd = view.split.vertical.rightbelow("%40"),
		},

		highlight = {
			italic = true,
		},

		ignore_blank_lines = true,
	})
	--- }}}

	-- Keybindings {{{
	nm("<leader>kr", function()
		cmd("IronRepl")
	end, "Toggle REPL window")
	nm("<leader>kR", function()
		cmd("IronRestart")
	end, "Restart REPL")
	nm("<leader>kx", iron.close_repl, "Close the REPL window")
	vm("<leader>kc", iron.visual_send, "Send the selected lines to REPL")
	nm("<leader>kl", iron.send_line, "Send the current line to REPL")
	nm("<leader>kp", iron.send_paragraph, "Send the current paragraph to REPL")
	nm("<leader>kf", iron.send_file, "Send the current file to REPL")
	nm("<leader>ku", iron.send_until_cursor, "Send to REPL from start to cursor")
	nm("<leader>kb", function()
		iron.send_code_block(false)
	end, "Send to code block to the REPL")
	nm("<leader>kn", function()
		iron.send_code_block(true)
	end, "Send to code block to the REPL and move to next")
	nm("<leader>k<cr>", function()
		iron.send(nil, string.char(13))
	end, "Send <CR> to REPL")
	nm("<leader>kC", function()
		iron.send(nil, string.char(03))
	end, "Send Ctrl-C to REPL")
	nm("<leader>kL", function()
		iron.send(nil, string.char(12))
	end, "Send Ctrl-L to REPL")
	-- }}}
end)

-- vim: fdm=marker fdl=0
