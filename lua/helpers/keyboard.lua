---@type vim.keymap.set
map = vim.keymap.set

---@type vim.keymap.del
delmap = vim.keymap.del

-- Keyboard
---@param key string The keybinding to map
---@param command string|function The command or function to execute
function nm(key, command)
	map("n", key, command, { noremap = true })
end

---@param key string
---@param command string|function
function im(key, command)
	map("i", key, command, { noremap = true })
end

---@param key string
---@param command string|function
function vm(key, command)
	map("v", key, command, { noremap = true })
end

---@param key string
---@param command string|function
function tm(key, command)
	map("t", key, command, { noremap = true })
end
