later(function()
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
	nm("<leader>tx", function()
		MiniPick.pickers.diagnostic()
	end, "Search diagnostics")
	nm("<leader>tt", function()
		MiniPick.builtin.grep_live()
	end, "Live grep")
	nm("<leader>ty", function()
		MiniExtra.pickers.hipatterns()
	end, "Find to-do marks")
end)
