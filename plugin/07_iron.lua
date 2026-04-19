later(function()
	-- Initialize plugins {{{
	add({ gh("Vigemus/iron.nvim") })
	-- }}}

	-- iron.nvim {{{1
	-- SQL REPL command with database finder {{{2
	local function get_first_local_db()
		local files = vim.fn.glob("*.{db,sqlite,sqlite3}", true, true)
		if #files > 0 then
			return files[1]
		end
		return nil
	end

	local db_file = get_first_local_db()
	local sql_cmd = { "sqlite3" }

	if db_file then
		table.insert(sql_cmd, db_file)
	end
	-- }}}
	-- Setup {{{2
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
				sql = {
					command = sql_cmd,
					block_dividers = { "-- @block", "--@block" },
					format = function(lines)
						local clean_lines = {}

						for _, line in ipairs(lines) do
							if not string.match(line, "^%s*%-%-%s*@block") then
								table.insert(clean_lines, line)
							end
						end

						return { table.concat(clean_lines, " ") .. "\r" }
					end,
				},
			},
			repl_filetype = function(bufnr, ft)
				return ft
			end,
			dap_integration = true,
			repl_open_cmd = function()
				local current_ft = vim.bo.filetype

				if current_ft == "sql" then
					vim.cmd("botright 25 split")
				else
					vim.cmd("botright 50 vsplit")
				end

				return vim.api.nvim_get_current_win()
			end,
		},

		highlight = {
			italic = true,
		},

		ignore_blank_lines = true,
	})
	-- }}}
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
