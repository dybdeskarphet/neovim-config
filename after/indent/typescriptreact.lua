local function tsx_indent()
	local lnum = vim.v.lnum
	local line = vim.fn.getline(lnum)

	if line:match("^%s*%)") then
		local pnum = vim.fn.prevnonblank(lnum - 1)
		while pnum > 0 do
			local pline = vim.fn.getline(pnum)
			if pline:match("return%s*%(") then
				return vim.fn.indent(pnum)
			end
			pnum = vim.fn.prevnonblank(pnum - 1)
		end
	end

	local prevlnum = vim.fn.prevnonblank(lnum - 1)
	if prevlnum > 0 then
		local prevline = vim.fn.getline(prevlnum)
		if prevline:match("return%s*%($") then
			return vim.fn.indent(prevlnum) + vim.fn.shiftwidth()
		end
	end

	local ok, indent = pcall(require, "nvim-treesitter.indent")
	if ok and indent and indent.get_indent then
		local res = indent.get_indent(lnum)
		if res and res >= 0 then
			return res
		end
	end

	return vim.fn.GetTypescriptIndent()
end

_G.tsx_indent = tsx_indent
vim.b.did_indent = 1
vim.bo.indentexpr = "v:lua.tsx_indent()"
