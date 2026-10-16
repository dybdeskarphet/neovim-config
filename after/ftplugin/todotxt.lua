local ns = vim.api.nvim_create_namespace("todotxt_dim")

vim.api.nvim_set_hl(0, "TodoDim", {
	link = "EndOfBuffer",
	nocombine = true,
})

local function dim_non_matching(pattern)
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
	if not pattern or pattern == "" then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		if not line:find(pattern, 1, true) then
			vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
				end_col = #line,
				hl_group = "TodoDim",
				line_hl_group = "TodoDim",
				priority = 10000,
			})
		end
	end
end
vim.keymap.set("n", "<leader>dc", function()
	local word = vim.fn.expand("<cword>")
	local pattern = vim.startswith(word, "@") and word or vim.fn.input("Filter context: @")
	if pattern ~= "" then
		dim_non_matching(vim.startswith(pattern, "@") and pattern or ("@" .. pattern))
	end
end, { buffer = true, desc = "Dim non-matching context lines" })

vim.keymap.set("n", "<leader>dp", function()
	local word = vim.fn.expand("<cword>")
	local pattern = vim.startswith(word, "+") and word or vim.fn.input("Filter project: +")
	if pattern ~= "" then
		dim_non_matching(vim.startswith(pattern, "+") and pattern or ("+" .. pattern))
	end
end, { buffer = true, desc = "Dim non-matching project lines" })

vim.keymap.set("n", "<leader>dl", function()
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end, { buffer = true, desc = "Clear project dimming" })
