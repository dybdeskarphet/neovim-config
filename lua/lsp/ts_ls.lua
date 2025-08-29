require("helpers.keyboard")

local function set_typescript_keymaps(client, bufnr)
	nm("grI", function()
		client:exec_cmd({
			command = "_typescript.organizeImports",
			arguments = { vim.api.nvim_buf_get_name(bufnr) },
		})
	end, "Organize Imports")
	nm("gru", function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				diagnostics = {},
				---@diagnostic disable-next-line: assign-type-mismatch
				only = { "source.removeUnusedImports.ts" },
			},
		})
	end, "Remove Unused Imports")
	nm("grm", function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				diagnostics = {},
				---@diagnostic disable-next-line: assign-type-mismatch
				only = { "source.addMissingImports.ts" },
			},
		})
	end, "Add Missing Imports")
end

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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("ts_ls.lsp", { clear = true }),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if client.name == "ts_ls" then
			set_typescript_keymaps(client, args.buf)
		end
	end,
})
