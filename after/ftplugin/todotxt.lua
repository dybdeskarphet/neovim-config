-- Keybindings {{{
nm("<leader>sn", "<cmd>TodoTxt new<cr>", "New todo entry")
nm("<leader>st", "<cmd>TodoTxt<cr>", "Toggle todo.txt")
nm("<leader>sd", "<cmd>DoneTxt<cr>", "Toggle done.txt")
nm("<leader>sg", "<cmd>TodoTxt ghost<cr>", "Toggle ghost text")
nm("<cr>", "<Plug>(TodoTxtToggleState)", "Toggle task state")
nm("<c-c>n", "<Plug>(TodoTxtCyclePriority)", "Cycle priority")
nm("<leader>sm", "<Plug>(TodoTxtMoveDone)", "Move done tasks")
nm("<leader>sss", "<Plug>(TodoTxtSortTasks)", "Sort tasks (default)")
nm("<leader>ssp", "<Plug>(TodoTxtSortByPriority)", "Sort by priority")
nm("<leader>ssc", "<Plug>(TodoTxtSortByContext)", "Sort by context")
nm("<leader>ssP", "<Plug>(TodoTxtSortByProject)", "Sort by project")
nm("<leader>ssd", "<Plug>(TodoTxtSortByDueDate)", "Sort by due date")
-- }}}

-- calcurse automation {{{
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	buffer = 0,
	callback = function()
		local write_handle = io.popen("calcursetodo")
		local write_result = write_handle:read("*a")
		write_handle:close()
		local sync_handle = io.popen("calcurse --export >~/.config/phone/calendar/calcurse.ics")
		local sync_result = sync_handle:read("*a")
		sync_handle:close()
	end,
})
-- }}}

-- Don't show warning when to-dos moved to `done` {{{
vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0, -- Attach only to this specific buffer
	callback = function()
		vim.cmd("silent! write!")
	end,
})
-- }}}

-- vim: fdm=marker fdl=0
