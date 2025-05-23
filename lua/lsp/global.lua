require("which-key").add({
    {"<leader>l", group = "LSP", desc = ""},
    {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "Code action"
    },
    {"<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol"},
    {"K", vim.lsp.buf.hover(), desc = "Hover information"},
    {"gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition"},
    {
        "gd",
        function() Snacks.picker.lsp_definitions() end,
        desc = "Goto Definition"
    }, {
        "gD",
        function() Snacks.picker.lsp_declarations() end,
        desc = "Goto Declaration"
    }, {
        "<leader>lx",
        function() Snacks.picker.diagnostics() end,
        desc = "Search diagnostics"
    }
})
