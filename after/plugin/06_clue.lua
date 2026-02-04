now(function()
	local miniclue = require("mini.clue")
	miniclue.setup({
		window = {
			delay = 100,
			config = {
				anchor = "SE",
				row = "auto",
				col = "auto",
				border = "none",
			},
		},
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },

			-- `[` and `]` keys
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },

			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },

			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },

			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },

			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },

			-- Window commands
			{ mode = "n", keys = "<C-w>" },

			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},

		clues = {
			-- Enhance this by adding descriptions for <Leader> mapping groups
			{ mode = "n", keys = "<leader>m", desc = "+Markdown" },
			{ mode = "n", keys = "<leader>S", desc = "+Spellcheck" },
			{ mode = "n", keys = "<leader>t", desc = "+Pick" },
			{ mode = "n", keys = "<leader>s", desc = "+todo.txt" },
			{ mode = "n", keys = "<leader>tg", desc = "+Git Pick" },
			{ mode = "n", keys = "<leader>l", desc = "+LSP Internal" },
			miniclue.gen_clues.square_brackets(),
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	})
end)

now(function()
	-- Global {{{
	nm("<leader>w", "<c-w>", "Press Ctrl-W")
	-- }}}
	-- Clipboard {{{
	map({ "v", "n" }, "<leader>p", '<esc>"+p', { noremap = true, desc = "Paste the clipboard after the cursor" })
	map({ "v", "n" }, "<leader>P", '<esc>"+P', { noremap = true, desc = "Paste the clipboard before the cursor" })
	map({ "v", "n" }, "<leader>y", '"+y', { noremap = true, desc = "Use yank options with system clipboard" })
	-- }}}
	-- Window Management {{{
	nm("<A-S-l>", "<cmd>wincmd L<cr>", "Move to far left")
	nm("<A-S-h>", "<cmd>wincmd H<cr>", "Move to far right")
	nm("<A-S-j>", "<cmd>wincmd J<cr>", "Move to far bottom")
	nm("<A-S-k>", "<cmd>wincmd K<cr>", "Move to far top")
	nm("<A-C-k>", "<cmd>vertical resize +5<cr>", "Increase the width of current window")
	nm("<A-C-j>", "<cmd>vertical resize -5<cr>", "Decrease the width of current window")
	-- }}}
	-- Buffer Movement {{{
	nm("<A-l>", "<cmd>bn<cr>", "Focus on the next buffer")
	nm("<A-h>", "<cmd>bp<cr>", "Focus on the previous buffer")
	-- }}}
	-- Spellcheck {{{
	nm("<leader>Ss", "<cmd>set spell<cr>", "Enable Turkish spellcheck")
	nm("<leader>Su", "<cmd>set nospell<cr>", "Disable Turkish spellcheck")
	-- }}}
	-- Open terminal {{{
	nm("<leader>T", function()
		cmd.vnew()
		cmd.term()
		cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 10)
	end, "Open a terminal window")
	tm("<Esc>", "<C-\\><C-n>", "Exit terminal insert mode")
	-- }}}
	-- Open History {{{
	nm("<leader>h", function()
		MiniNotify.show_history()
	end, "Open history")
	-- }}}
	-- Delete a buffer {{{
	nm("<A-q>", "<cmd>Bdelete<cr>", "Delete the buffer")
	-- }}}
	-- Move visual blocks {{{
	vm("K", ":m '<-2<CR>gv=gv", "Move the visual block up")
	vm("J", ":m '>+1<CR>gv=gv", "Move the visual block down")
	-- }}}
	-- Keybindings for convenience {{{
	map("n", "<esc><esc>", ":noh<cr>", { noremap = true, silent = true, desc = "Clear hihglights" })
	-- }}}
	-- Create splits {{{
	nm("<leader>\\", "<cmd>vsplit<cr>", "Create a vertical split")
	nm("<leader>-", "<cmd>split<cr>", "Create a horizontal split")
	-- }}}
end)
