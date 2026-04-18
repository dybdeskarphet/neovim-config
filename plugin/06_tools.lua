-- vimtex {{{
add({ gh("lervag/vimtex") })
g.vimtex_view_method = "zathura"
g.vimtex_view_general_viewer = "zathura"
g.vimtex_compiler_method = "latexrun"
-- }}}

later(function()
	-- Initialize plugins {{{
	add({
		"https://git.sr.ht/~nedia/auto-save.nvim",
		gh("brenoprata10/nvim-highlight-colors"),
	})
	-- }}}

	-- auto nohlsearch {{{
	cmd.packadd("nohlsearch")
	-- }}}

	-- mbbill/undotree {{{
	cmd.packadd("nvim.undotree")
	nm("<leader>u", function()
		require("undotree").open({
			command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew",
		})
	end, "Toggle Undotree")
	-- }}}

	-- mini.files {{{
	require("mini.files").setup()
	local map_split = function(buf_id, lhs, direction)
		local rhs = function()
			local cur_target = MiniFiles.get_explorer_state().target_window
			local new_target = vim.api.nvim_win_call(cur_target, function()
				cmd(direction .. " split")
				return vim.api.nvim_get_current_win()
			end)

			MiniFiles.set_target_window(new_target)
			MiniFiles.go_in()
		end

		local desc = "Split " .. direction
		map("n", lhs, rhs, { buffer = buf_id, desc = desc })
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			map_split(buf_id, "<C-s>", "belowright horizontal")
			map_split(buf_id, "<C-v>", "belowright vertical")
			map_split(buf_id, "<C-t>", "tab")
		end,
	})

	nm("T", function()
		MiniFiles.open()
	end, "Open mini.files")
	-- }}}

	-- auto-save.nvim {{{
	require("auto-save").setup({
		events = { "InsertLeave", "BufLeave" },
		silent = false,
	})
	-- }}}

	-- nvim-highlight-colors {{{
	require("nvim-highlight-colors").setup()
	-- }}}

	-- mini.pick {{{
	require("mini.pick").setup({
		window = {
			config = nil,
			prompt_caret = "▏",
			prompt_prefix = " ",
		},
	})
	require("mini.extra").setup()
	nm("<leader>b", function()
		MiniPick.builtin.buffers()
	end, "Buffers")
	nm("<leader>tgb", function()
		MiniExtra.pickers.git_branches()
	end, "Git branches")
	nm("<leader>tgo", function()
		MiniExtra.pickers.git_files()
	end, "Git files")
	nm("<leader>to", function()
		MiniPick.builtin.files()
	end, "Smart find files")
	nm("<leader>f", function()
		MiniPick.builtin.files()
	end, "Smart find files")
	nm("<leader>tx", function()
		MiniPick.pickers.diagnostic()
	end, "Search diagnostics")
	nm("<leader>tt", function()
		MiniPick.builtin.grep_live()
	end, "Live grep")
	nm("<leader>ty", function()
		MiniExtra.pickers.hipatterns()
	end, "Find to-do marks")
	-- }}}

	-- mini.git + mini.diff {{{
	require("mini.diff").setup({
		view = {
			--- @type 'sign' | 'number'.
			style = "number",
			signs = { add = "┃", change = "┃", delete = "_" },
			priority = 199,
		},

		source = nil,
		delay = {
			text_change = 200,
		},

		mappings = {
			apply = "gh",
			reset = "gH",
			textgbject = "gh",
			goto_first = "[H",
			goto_prev = "[h",
			goto_next = "]h",
			goto_last = "]H",
		},

		options = {
			algorithm = "histogram",
			indent_heuristic = true,
			linematch = 60,
			wrap_goto = false,
		},
	})
	require("mini.git").setup()
	-- }}}

	-- mini.comment {{{
	require("mini.comment").setup()
	-- }}}

	-- mini.bufremove {{{
	require("mini.bufremove").setup()
	-- }}}

	-- mini.ai + mini.surround + mini.pairs {{{
	require("mini.ai").setup()
	require("mini.surround").setup()
	-- }}}

	-- mini.clue {{{1
	local clue = require("mini.clue")
	clue.setup({
		-- Triggers {{{2
		triggers = {
			-- Leader triggers
			{ mode = { "n", "x" }, keys = "<Leader>" },

			-- `[` and `]` keys
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = { "n", "x" }, keys = "g" },

			-- Marks
			{ mode = { "n", "x" }, keys = "'" },
			{ mode = { "n", "x" }, keys = "`" },

			-- Registers
			{ mode = { "n", "x" }, keys = '"' },
			{ mode = { "i", "c" }, keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = { "n", "x" }, keys = "z" },
		},
		-- }}}
		-- Clues (grouping) {{{2
		clues = {
			{ mode = "n", keys = "<leader>m", desc = "+Markdown" },
			{ mode = "n", keys = "<leader>S", desc = "+Spellcheck" },
			{ mode = "n", keys = "<leader>t", desc = "+Pick" },
			{ mode = "n", keys = "<leader>r", desc = "+REPL" },
			{ mode = "n", keys = "<leader>s", desc = "+todo.txt" },
			{ mode = "n", keys = "<leader>tg", desc = "+Git Pick" },
			{ mode = "n", keys = "<leader>l", desc = "+LSP commands" },
			clue.gen_clues.square_brackets(),
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
		},
		-- }}}
		-- Window {{{2
		window = {
			delay = 100,
		},
		-- }}}
	})
	-- }}}

	-- mini.cmdline {{{
	require("mini.cmdline").setup({
		autocomplete = {
			delay = 600,
		},
	})
	-- }}}

	-- mini.notify, show history mapping {{{
	nm("<leader>h", require("mini.notify").show_history, "Open history")
	-- }}}
end)

-- vim: fdm=marker fdl=0
