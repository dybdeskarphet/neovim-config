-- Initialize plugins {{{
add({ gh("hat0uma/csvview.nvim") })
-- }}}

-- csvview.nvim {{{
require("csvview").setup({
	view = {
		---@type "highlight" | "border"
		display_mode = "highlight",
	},
})
-- }}}

-- vim: fdm=marker fdl=0
