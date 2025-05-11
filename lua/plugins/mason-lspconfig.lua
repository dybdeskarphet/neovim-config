return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {"mason-org/mason.nvim", "neovim/nvim-lspconfig"},
    config = function()
        local handlers = {
            function(server_name) -- default handler (optional)
                if server_name == "tsserver" then
                    server_name = "ts_ls"
                end
                local capabilities = require("blink.cmp").get_lsp_capabilities({
                    textDocument = {
                        foldingRange = {
                            dynamicRegistration = true,
                            lineFoldingOnly = true
                        }
                    }
                })
                lspconfig[server_name].setup({capabilities = capabilities})
            end,
            ["basedpyright"] = function()
                lspconfig.basedpyright.setup {
                    settings = {
                        basedpyright = {
                            analysis = {
                                autoSearchPaths = true,
                                typeCheckingMode = "standard"

                            }
                        }
                    }
                }
            end,
            ["ts_ls"] = function()
                lspconfig.ts_ls.setup {
                    root_dir = vim.fs.dirname(vim.fs.find({
                        'tsconfig.json', 'package.json'
                    }, {upward = true})[1])

                }
            end
        }
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "basedpyright", "rust_analyzer", "marksman", "jsonls",
                "ts_ls", "cssls", "bashls", "texlab", "hyprls", "html", "yamlls"
            },
            handlers = handlers
        });
    end
}
