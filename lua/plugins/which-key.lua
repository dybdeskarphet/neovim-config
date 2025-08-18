require("helpers.keyboard")

MiniDeps.add({
	source = "folke/which-key.nvim",
})

MiniDeps.now(function()
	require("which-key").setup()
	require("which-key").add({
		-- Global {{{
		{ "<leader>w", "<c-w>", desc = "Press Ctrl-W" },
		-- }}}
		-- Clipboard {{{
		{
			"<leader>p",
			'<esc>"+p',
			desc = "Paste the clipboard after the cursor",
			mode = { "v", "n" },
		},
		{
			"<leader>P",
			'<esc>"+P',
			desc = "Paste the clipboard before the cursor",
			mode = { "v", "n" },
		},
		{
			"<leader>y",
			'"+y',
			desc = "Use yank options with system clipboard",
			mode = { "v", "n" },
		},
		-- }}}
		-- Spellcheck {{{
		{ "<leader>s", group = "Spellcheck" },
		{
			"<leader>ss",
			"<cmd>set spell<cr>",
			desc = "Enable Turkish spellcheck",
		},
		{
			"<leader>su",
			"<cmd>set nospell<cr>",
			desc = "Disable Turkish spellcheck",
		},
		-- }}}
		-- Window Management {{{
		{ "<A-S-l>", "<cmd>wincmd L<cr>", desc = "Move to far left" },
		{ "<A-S-h>", "<cmd>wincmd H<cr>", desc = "Move to far right" },
		{ "<A-S-j>", "<cmd>wincmd J<cr>", desc = "Move to far bottom" },
		{ "<A-S-k>", "<cmd>wincmd K<cr>", desc = "Move to far top" },
		-- }}}
		-- Buffer Movement {{{
		{ "<A-l>", "<cmd>bn<cr>", desc = "Focus on the next buffer" },
		{ "<A-h>", "<cmd>bp<cr>", desc = "Focus on the previous buffer" },
		-- }}}
		-- Open terminal {{{
		{
			"<leader>T",
			function()
				vim.cmd.vnew()
				vim.cmd.term()
				vim.cmd.wincmd("J")
				vim.api.nvim_win_set_height(0, 10)
			end,
			desc = "Open a terminal window",
		},
		-- }}}
	})
	-- Move visual blocks {{{
	vm("K", ":m '<-2<CR>gv=gv")
	vm("J", ":m '>+1<CR>gv=gv")
	-- }}}
	-- Keybindings for convenience {{{
	map("n", "<esc><esc>", ":noh<cr>", { noremap = true, silent = true })
	-- }}}
end)
