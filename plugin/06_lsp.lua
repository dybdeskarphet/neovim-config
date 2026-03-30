later(function()
	-- Initialize plugins {{{
	add({
		gh("rafamadriz/friendly-snippets"),
		gh("stevearc/conform.nvim"),
		gh("mason-org/mason.nvim"),
		gh("neovim/nvim-lspconfig"),
		gh("mason-org/mason-lspconfig.nvim"),
	})
	-- }}}

	-- Custom LSP configurations {{{1
	-- basedpyright {{{2
	vim.lsp.config("basedpyright", {
		capabilities = {
			window = {
				workDoneProgress = false,
			},
		},
		root_markers = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			"pyrightconfig.json",
			".git",
		},
		settings = {
			basedpyright = {
				analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true },
			},
		},
	})
	-- }}}

	-- ts_ls {{{2
	vim.lsp.config("ts_ls", {
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		init_options = {
			preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				importModuleSpecifierPreference = "non-relative",
			},
		},
	})
	-- }}}

	-- lua_ls {{{2
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					},
					checkThirdParty = false,
				},
				completion = { callSnippet = "Replace" },
			},
		},
	})
	-- }}}

	-- taplo {{{2
	vim.lsp.config["taplo"] = {
		filetypes = { "toml" },
		root_markers = {
			"*.toml",
			".git",
		},
	}
	-- }}}

	-- tinymist {{{2
	vim.lsp.config("tinymist", {
		cmd = { "tinymist" },
		filetypes = { "typst" },
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onSave",
			semanticTokens = "disable",
		},
	})
	-- }}}
	-- }}}

	-- Mason {{{1
	-- Plugin configuration {{{2
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"fish_lsp",
			"basedpyright",
			"rust_analyzer",
			"marksman",
			"jsonls",
			"ts_ls",
			"cssls",
			"bashls",
			"texlab",
			"hyprls",
			"yamlls",
			"sqlls",
			"csharp_ls",
			"taplo",
		},
		automatic_enable = true,
	})
	-- }}}
	-- Tool installation {{{2
	local other_packages = { "prettierd", "stylua", "black", "eslint_d", "rustfmt", "shfmt" }
	local registry = require("mason-registry")
	local function ensure_installed()
		for _, tool in ipairs(other_packages) do
			local ok, p = pcall(registry.get_package, tool)
			if ok and not p:is_installed() then
				p:install()
			end
		end
	end
	if not pcall(registry.get_package, other_packages[1]) then
		registry.refresh(ensure_installed)
	else
		ensure_installed()
	end
	-- }}}
	-- }}}

	-- conform.nvim {{{
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			html = { "prettierd", lsp_format = "fallback" },
			javascript = { "prettierd", "eslint_d", lsp_format = "fallback" },
			typescript = { "prettierd", "eslint_d", lsp_format = "fallback" },
			markdown = { "prettierd", lsp_format = "fallback" },
			typescriptreact = { "prettierd", "eslint_d", lsp_format = "fallback" },
			javascriptreact = { "prettierd", "eslint_d", lsp_format = "fallback" },
			sh = { "shfmt" },
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
	nm("<leader>x", require("mini.extra").pickers.diagnostic, "Toggle trouble")

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

	nm("<leader>ld", function()
		lsp.buf.definition()
	end, "Go to definition")

	nm("<leader>lD", function()
		lsp.buf.declaration()
	end, "Goto Declaration")

	nm("<leader>lR", "<cmd>LspRestart<cr>", "Restart LSP")
	nm("<leader>li", "<cmd>LspInfo<cr>", "Get LSP info")
	nm("<leader>lp", "<cmd>LspStop<cr>", "Stop LSP")
	nm("<leader>ls", "<cmd>LspStart<cr>", "Start LSP")
	-- }}}
end)
-- vim: fdm=marker fdl=0
