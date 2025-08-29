require("helpers.mini")
require("helpers.keyboard")

local build_luasnip = function(ctx)
	local luasnip_path = ctx.path -- comes from hook argument

	print("LuaSnip path: " .. luasnip_path)
	if vim.fn.isdirectory(luasnip_path) == 1 then
		local handle = io.popen("cd " .. luasnip_path .. " && make install_jsregexp")
		local result = handle:read("*a")
		handle:close()
		print(result)
	else
		print("LuaSnip directory not found: " .. luasnip_path)
	end
end

add({
	source = "mason-org/mason-lspconfig.nvim",
	depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
})

add({
	source = "stevearc/conform.nvim",
})

add({
	source = "zapling/mason-conform.nvim",
	depends = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
})

add({
	source = "onsails/lspkind.nvim",
})

add({
	source = "L3MON4D3/LuaSnip",
	checkout = "v2.4.0",
	hooks = {
		post_install = build_luasnip,
		post_checkout = build_luasnip,
	},
})

add({
	source = "folke/trouble.nvim",
})

later(function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
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
		},
		automatic_enable = true,
	})

	local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"

	for _, file in ipairs(vim.fn.readdir(lsp_path)) do
		if file:match("%.lua$") then
			local module_name = "lsp." .. file:gsub("%.lua$", "")
			require(module_name)
		end
	end

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			javascript = { "prettierd", lsp_format = "fallback" },
			typescript = { "prettierd", lsp_format = "fallback" },
			typescriptreact = { "prettierd", lsp_format = "fallback" },
			javascriptreact = { "prettierd", lsp_format = "fallback" },
			sh = { "shfmt" },
			c = { "clang-format" },
			cs = { "csharpier", lsp_format = "fallback" },
			typst = { "prettypst", lsp_format = "fallback" },
		},
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})

	require("mason-conform").setup()
	require("trouble").setup()

	nm("<leader>F", function()
		require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	end, "Format the buffer")
	nm("<leader>x", "<cmd>Trouble diagnostics toggle<cr>", "Toggle trouble")

	require("luasnip.loaders.from_vscode").lazy_load()
end)
