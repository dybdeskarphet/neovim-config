require("which-key").add({
    {"<leader>l", group = "LSP", desc = ""},
    {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "Code action"
    },
    {"<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol"},
    {
        "<leader>lx",
        function() Snacks.picker.diagnostics() end,
        desc = "Search diagnostics"
    }, {"K", vim.lsp.buf.hover(), desc = "Hover information"},
    {"<leader>l", group = "LSP Go-to", desc = ""}, {
        "<leader>gd",
        function() Snacks.picker.lsp_definitions() end,
        desc = "Goto Definition"
    },
    {
        "gr",
        function() Snacks.picker.lsp_references() end,
        desc = "List references"
    }, {
        "gD",
        function() Snacks.picker.lsp_declarations() end,
        desc = "Goto Declaration"
    }
})
