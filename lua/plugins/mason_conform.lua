return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	},
	{ "stevearc/conform.nvim" },
	{
		"zapling/mason-conform.nvim",
		dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"basedpyright",
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
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})

			require("which-key").add({
				{
					"<leader>F",
					function()
						require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
					end,
					desc = "Format the buffer",
				},
			})

			require("mason-conform").setup()
		end,
	},
}
