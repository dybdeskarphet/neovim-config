-- mini.deps helpers {{{
later = function(callback)
	require("mini.misc").safely("later", callback)
end
-- }}}

-- Vim helpers {{{
b = vim.b
cmd = vim.cmd
fn = vim.fn
g = vim.g
go = vim.go
opt = vim.opt
wo = vim.wo
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

-- vim.pack {{{
add = vim.pack.add
ver = vim.version.range
gh = function(x)
	return "https://github.com/" .. x
end

local function complete_packages(arg_lead)
	arg_lead = arg_lead or ""

	return vim.iter(vim.pack.get())
		:map(function(pack)
			return pack.spec.name
		end)
		:filter(function(name)
			return vim.startswith(name, arg_lead)
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackUpdate", function(info)
	if #info.fargs ~= 0 then
		vim.pack.update(info.fargs, { force = info.bang })
	else
		local prompt = "Do you want to update ALL packages?"
		local choice = vim.fn.confirm(prompt, "&Yes\n&No", 2)

		if choice == 1 then
			vim.notify("Updating everything.", vim.log.levels.INFO)
			vim.pack.update(nil, { force = info.bang })
		else
			vim.notify("Update aborted.", vim.log.levels.WARN)
		end
	end
end, {
	desc = "Update packages",
	nargs = "*",
	bang = true,
	complete = complete_packages,
})

vim.api.nvim_create_user_command("PackDelete", function(info)
	vim.pack.del(info.fargs, { force = info.bang })
end, {
	desc = "Delete packages",
	nargs = "+",
	bang = true,
	complete = complete_packages,
})
-- }}}

-- vim: fdm=marker fdl=0
