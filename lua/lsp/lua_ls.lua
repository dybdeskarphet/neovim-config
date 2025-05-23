vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {globals = {"vim"}},
            workspace = {
                library = {
                    vim.env.VIMRUNTIME, "${3rd}/luv/library",
                    "${3rd}/busted/library"
                },
                checkThirdParty = false
            },
            completion = {callSnippet = "Replace"}
        }
    }
})
