--[[
  File: mason.lua & LSP configuration
  Description: Mason plugin configuration (with lspconfig)
  See: https://github.com/williamboman/mason.nvim
]] local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local handlers = {
    function(server_name) -- default handler (optional)
        if server_name == "tsserver" then server_name = "ts_ls" end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({capabilities = capabilities})
    end,
    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
            filetypes = {"rust"},
            root_dir = util.root_pattern("Cargo.toml"),
            settings = {['rust-analyzer'] = {cargo = {allFeatures = true}}}
        })
    end
}

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls", -- LSP for Lua language
        "pyright", -- LSP for Python
        "rust_analyzer", -- LSP for Rust
        "marksman", -- LSP for Markdown
        "jsonls", -- LSP for JSON
        "cssls", -- LSP for CSS
        "bashls", -- LSP for shell scripts
        "tsserver" -- LSP for TS and JS
    },
    handlers = handlers
});
mason_lspconfig.setup_handlers(handlers)

-- Setup every needed language server in lspconfig

local signs = {Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " "}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
