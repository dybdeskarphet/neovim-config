require("helpers.mini")

local build_markdown_preview = function(ctx)
	local plugin_path = ctx.path

	if vim.fn.isdirectory(plugin_path) == 1 then
		local handle = io.popen("cd " .. plugin_path .. " && npm install")
		local result = handle:read("*a")
		handle:close()
		print(result)
	else
		print("Plugin directory not found: " .. plugin_path)
	end
end

add({
	source = "iamcco/markdown-preview.nvim",
	hooks = {
		post_install = build_markdown_preview,
		post_checkout = build_markdown_preview,
	},
})

add({
	source = "arminveres/md-pdf.nvim",
	checkout = "main",
})

add({
	source = "MeanderingProgrammer/render-markdown.nvim",
	depends = {
		"nvim-treesitter/nvim-treesitter",
	},
})

add({
	source = "marcocofano/excalidraw.nvim",
})

add({
	source = "Myzel394/easytables.nvim",
})

later(function()
	-- 1. Define the actual logic in Lua (Global)
	_G.open_markdown_preview = function(url)
		-- For Arch Linux/Firefox
		local cmd = { "chromium", "--app=", url }

		-- Run asynchronously
		vim.fn.jobstart(cmd, { detach = true })
	end

	-- 2. Create a tiny Vimscript bridge
	-- We have to do this because the plugin doesn't recognize 'v:lua' directly
	vim.cmd([[
    function! OpenMarkdownPreviewBridge(url)
      call v:lua.open_markdown_preview(a:url)
    endfunction
    ]])

	-- 3. Point the plugin to the Vimscript bridge
	g.mkdp_browserfunc = "OpenMarkdownPreviewBridge"
	g.mkdp_filetypes = { "markdown" }
	g.mkdp_page_title = "${name}"
	g.mkdp_port = "9033"
	g.mkdp_auto_close = 0
	require("md-pdf").setup({
		pandoc_user_args = {
			"-V lang=tr", -- long options
		},
		preview_cmd = function()
			return "zathura"
		end,
	})

	require("render-markdown").setup({

		heading = {
			enabled = true,
			sign = true,
			position = "inline",
			icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
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
				custom = {
					todo = {
						raw = "[-]",
						rendered = "󰥔 ",
						highlight = "RenderMarkdownTodo",
						scope_highlight = nil,
					},
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
	})

	require("excalidraw").setup({
		storage_dir = "~/.excalidraw",
		templates_dir = "~/.excalidraw/templates",
		open_on_create = true,
		relative_path = true,
		picker = {
			link_scene_mapping = "<C-l>",
		},
	})

	require("easytables").setup()

	nm("<leader>mp", "<cmd>MarkdownPreview<CR>", "Preview markdown file")
	nm("<leader>mt", "<cmd>RenderMarkdown toggle<CR>", "Toggle markdown rendering")
	nm("<leader>mc", function()
		require("md-pdf").convert_md_to_pdf()
	end, "Convert markdown file to PDF")
end)
