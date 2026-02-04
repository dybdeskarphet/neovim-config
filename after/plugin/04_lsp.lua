local build_luasnip = function(ctx)
	local luasnip_path = ctx.path

	if vim.fn.isdirectory(luasnip_path) == 1 then
		notify("Building jsregexp for LuaSnip...", vim.log.levels.INFO)
		vim.system({ "make", "install_jsregexp" }, { cwd = luasnip_path }, function(obj)
			vim.schedule(function()
				if obj.code == 0 then
					notify("jsregexp installed successfully!", vim.log.levels.INFO)
				else
					notify("Build failed:\n" .. obj.stderr, vim.log.levels.ERROR)
				end
			end)
		end)
	else
		notify("LuaSnip directory not found: " .. luasnip_path, vim.log.levels.ERROR)
	end
end

add({
	source = "mason-org/mason-lspconfig.nvim",
	depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
})

add({ source = "mfussenegger/nvim-lint" })

add({ source = "stevearc/conform.nvim" })

add({
	source = "zapling/mason-conform.nvim",
	depends = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
})

add({
	source = "rshkarin/mason-nvim-lint",
	depends = { "williamboman/mason.nvim", "mfussenegger/nvim-lint" },
})

add({ source = "onsails/lspkind.nvim" })

add({
	source = "L3MON4D3/LuaSnip",
	checkout = "v2.4.0",
	hooks = {
		post_install = build_luasnip,
		post_checkout = build_luasnip,
	},
})

add({ source = "folke/trouble.nvim" })

now(function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"fish_lsp",
			"basedpyright",
			"tinymist",
			"rust_analyzer",
			"marksman",
			"jsonls",
			"ts_ls",
			"cssls",
			"bashls",
			"texlab",
			"hyprls",
			"html",
			"yamlls",
			"sqlls",
			"csharp_ls",
			"arduino_language_server",
			"clangd",
			"taplo",
			"nil_ls",
		},
		automatic_enable = true,
	})

	local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"
	local lsp = vim.lsp

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "eslint_d", lsp_format = "fallback" },
			typescript = { "prettierd", "eslint_d", lsp_format = "fallback" },
			markdown = { "prettierd", lsp_format = "fallback" },
			typescriptreact = { "prettierd", "eslint_d", lsp_format = "fallback" },
			javascriptreact = { "prettierd", "eslint_d", lsp_format = "fallback" },
			sh = { "shfmt" },
			c = { "clang-format" },
			cs = { "csharpier", lsp_format = "fallback" },
			typst = { "prettypst", lsp_format = "fallback" },
			toml = { "taplo", lsp_format = "fallback" },
			nix = { "alejandra", lsp_format = "fallback" },
			fish = { lsp_format = "prefer" },
		},
		format_on_save = function(bufnr)
			if g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	})

	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			-- FormatDisable! will disable formatting just for this buffer
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

	require("lint").linters_by_ft = {
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})

	require("mason-nvim-lint").setup({
		ensure_installed = { "eslint_d" },
	})

	require("mason-conform").setup()
	require("trouble").setup()

	nm("<leader>F", function()
		require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	end, "Format the buffer")
	nm("<leader>x", "<cmd>Trouble diagnostics toggle<cr>", "Toggle trouble")

	require("luasnip.loaders.from_vscode").lazy_load()

	nm("grh", function()
		lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
	end, "Enable inlay hints")

	nm("K", function()
		lsp.buf.hover()
	end, "Diagnostics float or LSP hover")

	nm("<leader>k", function()
		vim.diagnostic.open_float(nil, { focusable = true })
	end, "Diagnostics float or LSP hover")

	nm("gra", function()
		lsp.buf.code_action()
	end, "Code action")

	nm("grn", function()
		lsp.buf.rename()
	end, "Rename symbol")

	nm("grr", function()
		MiniExtra.pickers.lsp({ scope = "references" })
	end, "List references")

	nm("gd", function()
		lsp.buf.definition()
	end, "Go to definition")

	nm("gD", function()
		lsp.buf.declaration()
	end, "Goto Declaration")

	nm("<leader>lr", "<cmd>LspRestart<cr>", "Restart LSP")
	nm("<leader>li", "<cmd>LspInfo<cr>", "Get LSP info")
	nm("<leader>lp", "<cmd>LspStop<cr>", "Stop LSP")
	nm("<leader>ls", "<cmd>LspStart<cr>", "Start LSP")
end)
