return {
    'saecki/crates.nvim',
    tag = 'stable',
    opts = {
        lsp = {
            enabled = true,
            on_attach = function(client, bufnr) end,
            actions = true,
            completion = true,
            hover = true
        }
    }
}
