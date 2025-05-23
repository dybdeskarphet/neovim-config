local function set_typescript_keymaps(client, bufnr)
    require("which-key").add({
        {
            "<leader>goi",
            function()
                client:exec_cmd({
                    command = "_typescript.organizeImports",
                    arguments = {vim.api.nvim_buf_get_name(bufnr)}
                })
            end,
            desc = "Organize Imports"
        }, {
            "<leader>gru",
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        diagnostics = {},
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        only = {"source.removeUnusedImports.ts"}
                    }
                })
            end,
            desc = "Remove Unused Imports"
        }, {
            '<leader>gmi',
            function()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        diagnostics = {},
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        only = {"source.addMissingImports.ts"}
                    }
                })
            end,
            desc = "Add Missing Imports"
        }
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("ts_ls.lsp", {clear = true}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        if client.name == "ts_ls" then
            set_typescript_keymaps(client, bufnr)
        end
    end
})
