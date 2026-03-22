-- mini.deps helpers {{{
later, add = MiniDeps.later, MiniDeps.add
-- }}}

-- Vim helpers {{{
fn = vim.fn
opt = vim.opt
go = vim.go
wo = vim.wo
cmd = vim.cmd
g = vim.g
b = vim.b
-- }}}

-- Keymap helpers {{{
---@type vim.keymap.set
map = vim.keymap.set

---@type vim.keymap.del
delmap = vim.keymap.del

-- Keyboard
---@param key string The keybinding to map
---@param command string|function The command or function to execute
---@param desc string Description of the command
function nm(key, command, desc)
	map("n", key, command, { noremap = true, desc = desc })
end

---@param key string
---@param command string|function
---@param desc string Description of the command
function im(key, command, desc)
	map("i", key, command, { noremap = true, desc = desc })
end

---@param key string
---@param command string|function
---@param desc string Description of the command
function vm(key, command, desc)
	map("v", key, command, { noremap = true, desc = desc })
end

---@param key string
---@param command string|function
---@param desc string Description of the command
function tm(key, command, desc)
	map("t", key, command, { noremap = true, desc = desc })
end
-- }}}

-- Other helpers {{{
function toEpoch(dateStr)
	local year, month, day = dateStr:match("(%d+)-(%d+)-(%d+)")
	return os.time({
		year = tonumber(year),
		month = tonumber(month),
		day = tonumber(day),
		hour = 0,
		min = 0,
		sec = 0,
	})
end
-- }}}

-- Highlight helpers {{{
function set_highlights(tbl)
	for group, opts in pairs(tbl) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

function set_hl_color(group_name, fg_color, bg_color)
	local hl = vim.api.nvim_get_hl(0, { name = group_name })

	if fg_color then
		hl.fg = fg_color
	end

	if bg_color then
		hl.bg = bg_color
	end

	vim.api.nvim_set_hl(0, group_name, hl)
end
-- }}}

-- mini.notify {{{1
require("mini.notify").setup({
	lsp_progress = {
		enable = true,
	},
})
vim.notify = require("mini.notify").make_notify({
	ERROR = { duration = 5000, hl_group = "DiagnosticError" },
	WARN = { duration = 5000, hl_group = "DiagnosticWarn" },
	INFO = { duration = 5000, hl_group = "MiniNotifyNormal" },
	DEBUG = { duration = 0, hl_group = "DiagnosticHint" },
	TRACE = { duration = 0, hl_group = "MiniNotifyNormal" },
	OFF = { duration = 0, hl_group = "MiniNotifyNormal" },
})
notify = vim.notify
-- }}}

-- vim: fdm=marker fdl=0
