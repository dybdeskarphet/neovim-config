return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {"mason-org/mason.nvim", "neovim/nvim-lspconfig"},
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "basedpyright", "rust_analyzer", "marksman", "jsonls",
                "ts_ls", "cssls", "bashls", "texlab", "hyprls", "html",
                "yamlls", "sqlls"
            }
        });

        local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp"

        for _, file in ipairs(vim.fn.readdir(lsp_path)) do
            if file:match("%.lua$") then
                local module_name = "lsp." .. file:gsub("%.lua$", "")
                require(module_name)
            end
        end
    end
}
