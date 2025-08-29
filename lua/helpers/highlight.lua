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
