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
