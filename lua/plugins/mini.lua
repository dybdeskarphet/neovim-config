return {
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	{ "echasnovski/mini.ai", version = "*" },
	{ "echasnovski/mini.surround", version = "*", opts = {} },
	{
		"echasnovski/mini.starter",
		version = "*",
		config = function()
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
		end,
	},
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.icons", version = "*" },
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				},
			})
		end,
	},
	{ "echasnovski/mini.cursorword", version = "*", opts = {} },
}
