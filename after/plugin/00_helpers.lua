opt = vim.opt
cmd = vim.cmd
g = vim.g
b = vim.b

now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add

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
