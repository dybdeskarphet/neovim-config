-- Initialize plugins {{{
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local data = ev.data
		if data.spec.name == "markdown-preview.nvim" and data.kind ~= "delete" then
			local cmd = vim.fn.has("win32") == 1 and { "cmd.exe", "/c", "install.cmd" } or { "./install.sh" }
			vim.system(cmd, { cwd = data.path .. "/app" }):wait()
		end
	end,
})

add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	gh("arminveres/md-pdf.nvim"),
	gh("Myzel394/easytables.nvim"),
	gh("sammaji/markdown-preview.nvim"),
})
-- }}}

-- md-pdf.nvim {{{
require("md-pdf").setup({
	pdf_engine = "typst",
	margins = "2cm",
	toc = true,
	pandoc_user_args = {
		"--metadata-file",
		vim.fn.stdpath("config") .. "/pandoc/typst.yaml",
	},
	preview_cmd = function()
		return "zathura"
	end,
})
-- }}}

-- markdown-preview {{{
require("markdown-preview").setup({
	theme = "dark",
	browser = { "chromium", "--new-window" },
	preview_options = {
		sync_scroll_type = "top",
		front_matter = "panel",
	},
})
-- }}}

-- render-markdown.nvim {{{
require("render-markdown").setup({
	heading = {
		enabled = true,
		sign = true,
		position = "inline",
		icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
		signs = { " " },
		width = "block", -- full, block
		left_margin = 0,
		left_pad = 3,
		right_pad = 3,
		min_width = 0,
		border = true,
		border_virtual = false,
		border_prefix = false,
		above = "▄",
		below = "▀",
		backgrounds = {
			"RenderMarkdownH1Bg",
			"RenderMarkdownH2Bg",
			"RenderMarkdownH3Bg",
			"RenderMarkdownH4Bg",
			"RenderMarkdownH5Bg",
			"RenderMarkdownH6Bg",
		},
		-- The 'level' is used to index into the list using a clamp
		-- Highlight for the heading and sign icons
		foregrounds = {
			"RenderMarkdownH1",
			"RenderMarkdownH2",
			"RenderMarkdownH3",
			"RenderMarkdownH4",
			"RenderMarkdownH5",
			"RenderMarkdownH6",
		},
	},
	bullet = {
		-- Turn on / off list bullet rendering
		enabled = true,
		-- Replaces '-'|'+'|'*' of 'list_item'
		-- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
		-- If a function is provided both of these values are passed in using 1 based indexing
		-- If a list is provided we index into it using a cycle based on the level
		-- If the value at that level is also a list we further index into it using a clamp based on the index
		-- If the item is a 'checkbox' a conceal is used to hide the bullet instead
		icons = { "", "", "", "" },
		-- Replaces 'n.'|'n)' of 'list_item'
		-- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
		-- If a function is provided both of these values are passed in using 1 based indexing
		-- If a list is provided we index into it using a cycle based on the level
		-- If the value at that level is also a list we further index into it using a clamp based on the index
		-- Padding to add to the left of bullet point
		ordered_icons = function(ctx)
			local value = vim.trim(ctx.value)
			local index = tonumber(value:sub(1, #value - 1))
			return ("%d."):format(index > 1 and index or ctx.index)
		end,
		left_pad = 0,
		-- Padding to add to the right of bullet point
		right_pad = 0,
		-- Highlight for the bullet icon
		highlight = "RenderMarkdownBullet",
	},
	checkbox = {
		enabled = true,
		--  inline:  underlying text is concealed resulting in a left aligned icon
		--  overlay: result is left padded with spaces to hide any additional text
		position = "inline",
		unchecked = {
			icon = "󰄱 ",
			highlight = "RenderMarkdownUnchecked",
			scope_highlight = nil,
		},
		checked = {
			icon = "󰱒 ",
			highlight = "RenderMarkdownChecked",
			--   'raw':             Matched against the raw text of a 'shortcut_link'
			--   'rendered':        Replaces the 'raw' value when rendering
			--   'highlight':       Highlight for the 'rendered' icon
			--   'scope_highlight': Highlight for item associated with custom checkbox
		},
		custom = {
			todo = {
				raw = "[-]",
				rendered = "󰥔 ",
				highlight = "String",
				scope_highlight = nil,
			},
			none = {
				raw = "[?]",
				rendered = "󰟢 ",
				highlight = "GruvboxMinimalBlue",
				scope_highlight = nil,
			},
		},
	},
	latex = {
		enabled = true,
		render_modes = false,
		converter = { "utftex", "latex2text" },
		highlight = "RenderMarkdownMath",
		position = "center",
		top_pad = 0,
		bottom_pad = 0,
	},
	code = {
		border = "thin",
	},
})
-- }}}

-- easytables.nvim {{{
require("easytables").setup()
-- }}}

-- Keybindings {{{
nm("<leader>mp", "<cmd>MarkdownPreview<CR>", "Preview markdown file")
nm("<leader>mt", "<cmd>RenderMarkdown toggle<CR>", "Toggle markdown rendering")
nm("<leader>mc", function()
	require("md-pdf").convert_md_to_pdf()
end, "Convert markdown file to PDF")
-- }}}

-- vim: fdm=marker fdl=0
