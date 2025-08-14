return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		lazygit = { enabled = true },
		explorer = { enabled = false },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		terminal = { enabled = true, terminal = { auto_close = true } },
		quickfile = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		indent = {
			enabled = true,
			only_scope = true,
			only_current = true,
			indent = {
				enabled = true,
				char = "╵",
				hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
			},
			scope = {
				enabled = true,
				char = "│",
				hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
			},
			chunk = {
				-- when enabled, scopes will be rendered as chunks, except for the
				-- top-level scope which will be rendered as a scope.
				enabled = true,
				-- only show chunk scopes in the current window
				only_current = false,
				priority = 200,
				hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					-- corner_top = "╭",
					-- corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},
		},
		scope = { enabled = true },
	},
	config = function(_, opts)
		-- Snacks Setup {{{
		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#595959" })
		vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#ffc34d" })
		vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#ffc34d" })
		require("snacks").setup(opts)
		-- }}}
		-- Keybindings {{{
		require("which-key").add({
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{ "<leader>t", group = "Picker" },
			{ "<leader>tg", group = "Git" },
			{
				"<leader>tgb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git branches",
			},
			{
				"<leader>tgo",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Git files",
			},
			{
				"<leader>to",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart find files",
			},
			{
				"<leader>tt",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>tq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix list",
			},
			{
				"<leader>th",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notifications",
			},
			{
				"<leader>ty",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Find to-do marks",
			},
			{
				"<leader>T",
				function()
					Snacks.terminal.toggle()
				end,
				desc = "Open vertical terminal buffer",
			},
			{
				"<leader>G",
				function()
					Snacks.lazygit.open()
				end,
			},
		})
		-- }}}
	end,
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
