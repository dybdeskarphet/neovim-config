later(function()
	-- Initialize plugins {{{
	add({
		gh("rafamadriz/friendly-snippets"),
		gh("stevearc/conform.nvim"),
		gh("neovim/nvim-lspconfig"),
		gh("kosayoda/nvim-lightbulb"),
	})
	-- }}}

	-- Custom LSP configurations {{{1
	-- }}}

	-- conform.nvim {{{
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			html = { "prettierd", lsp_format = "fallback" },
			javascript = { "prettierd", lsp_format = "fallback" },
			typescript = { "prettierd", lsp_format = "fallback" },
			svelte = { "prettier", lsp_format = "fallback" },
			markdown = { "prettierd", lsp_format = "fallback" },
			typescriptreact = { "prettierd", lsp_format = "fallback" },
			javascriptreact = { "prettierd", lsp_format = "fallback" },
			sh = { "shfmt" },
			nix = { "nixfmt", lsp_format = "fallback" },
			toml = { "taplo", lsp_format = "fallback" },
			fish = { lsp_format = "prefer" },
		},
		format_on_save = function(bufnr)
			if g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	})
	-- }}}

	-- Mappings {{{
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			b.disable_autoformat = true
			notify("Disabled autoformat for current buffer")
		else
			g.disable_autoformat = true
		end
	end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	})
	vim.api.nvim_create_user_command("FormatEnable", function()
		b.disable_autoformat = false
		g.disable_autoformat = false
		notify("Enabled autoformat for current buffer")
	end, {
		desc = "Re-enable autoformat-on-save",
	})
	nm("<leader>lfe", "<cmd>FormatEnable<cr>", "Enable formatting")
	nm("<leader>lfd", "<cmd>FormatDisable!<cr>", "Disable formatting")

	nm("<leader>F", function()
		require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	end, "Format the buffer")
	nm("<leader>x", function()
		MiniExtra.pickers.diagnostic()
	end, "Toggle diagnostics (clue)")
	nm("<leader>X", vim.diagnostic.setloclist, "Toggle diagnostics (split)")

	local lsp = vim.lsp

	nm("<leader>lh", function()
		local filter = { bufnr = 0 }
		lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(filter), filter)
	end, "Toggle inlay hints")

	nm("K", function()
		lsp.buf.hover()
	end, "LSP hover")

	nm("<leader>d", function()
		vim.diagnostic.open_float(nil, { focusable = true })
	end, "Diagnostics float")

	nm("<leader>la", function()
		lsp.buf.code_action()
	end, "Code action")

	nm("<leader>ln", function()
		lsp.buf.rename()
	end, "Rename symbol")

	nm("<leader>lr", function()
		MiniExtra.pickers.lsp({ scope = "references" })
	end, "List references")

	nm("gd", function()
		lsp.buf.definition()
	end, "Go to definition")

	nm("gD", function()
		lsp.buf.declaration()
	end, "Go to Declaration")

	nm("<leader>lR", "<cmd>lsp restart<cr>", "Restart LSP")
	nm("<leader>li", "<cmd>checkhealth vim.lsp<cr>", "Get LSP info")
	nm("<leader>lp", "<cmd>lsp stop<cr>", "Stop LSP")
	nm("<leader>ls", "<cmd>lsp start<cr>", "Start LSP")
	-- }}}

	-- Show code actions bulb {{{
	require("nvim-lightbulb").setup({
		autocmd = { enabled = true },
		sign = { enabled = false, text = "" },
		virtual_text = { enabled = true, text = "" },
	})
	-- }}}
end)
-- vim: fdm=marker fdl=0
