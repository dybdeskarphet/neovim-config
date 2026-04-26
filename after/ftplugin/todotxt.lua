-- Custom Sorting: Priority (A-Z) -> Size (9-0) {{{
local function sort_by_priority_and_size()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	table.sort(lines, function(a, b)
		local prio_a = a:match("^%(([A-Z])%)") or "~"
		local prio_b = b:match("^%(([A-Z])%)") or "~"

		local size_a = tonumber(a:match("size:(%d)")) or -1
		local size_b = tonumber(b:match("size:(%d)")) or -1

		if prio_a == prio_b then
			return size_a > size_b
		else
			return prio_a < prio_b
		end
	end)

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end
-- }}}

-- Keybindings {{{
local todo = require("todotxt")
map("n", "<leader>sn", todo.capture_todo, { buffer = true, desc = "New todo entry" })
map("n", "<leader>st", todo.toggle_todotxt, { desc = "Toggle todo.txt" })
map("n", "<leader>sd", todo.toggle_donetxt, { buffer = true, desc = "Toggle done.txt" })
map("n", "<leader>sg", todo.toggle_ghost_text, { buffer = true, desc = "Toggle ghost text" })
map("n", "<cr>", todo.toggle_todo_state, { buffer = true, desc = "Toggle task state" })
map("n", "<c-c>n", todo.cycle_priority, { buffer = true, desc = "Cycle priority" })
map("n", "<leader>sm", todo.move_done_tasks, { buffer = true, desc = "Move done tasks" })
map("n", "<leader>sss", todo.sort_tasks, { buffer = true, desc = "Sort tasks (default)" })
map("n", "<leader>ssp", todo.sort_tasks_by_priority, { buffer = true, desc = "Sort by priority" })
map("n", "<leader>ssc", todo.sort_tasks_by_context, { buffer = true, desc = "Sort by context" })
map("n", "<leader>ssP", todo.sort_tasks_by_project, { buffer = true, desc = "Sort by project" })
map("n", "<leader>ssd", todo.sort_tasks_by_due_date, { buffer = true, desc = "Sort by due date" })
map("n", "<leader>ssz", sort_by_priority_and_size, { buffer = true, desc = "Sort by priority then size" })
-- }}}

-- vim: fdm=marker fdl=0
