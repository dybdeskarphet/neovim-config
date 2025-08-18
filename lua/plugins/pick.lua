MiniDeps.later(function()
	require("mini.pick").setup({
		window = {
			config = nil,
			prompt_caret = "▏",
			prompt_prefix = " ",
		},
	})
	require("mini.extra").setup()
	require("which-key").add({
		{
			"<leader>b",
			function()
				MiniPick.builtin.buffers()
			end,
			desc = "Buffers",
		},
		{ "<leader>tg", group = "Git" },
		{ "<leader>t", group = "Picker" },
		{
			"<leader>tgb",
			function()
				MiniExtra.pickers.git_branches()
			end,
			desc = "Git branches",
		},
		{
			"<leader>tgo",
			function()
				MiniExtra.pickers.git_files()
			end,
			desc = "Git files",
		},
		{
			"<leader>to",
			function()
				MiniPick.builtin.files()
			end,
			desc = "Smart find files",
		},
		{
			"<leader>tt",
			function()
				MiniPick.builtin.grep_live()
			end,
			desc = "Live grep",
		},
		{
			"<leader>ty",
			function()
				MiniExtra.pickers.hipatterns()
			end,
			desc = "Find to-do marks",
		},
	})
end)
