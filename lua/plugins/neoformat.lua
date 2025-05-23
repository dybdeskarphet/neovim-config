require 'globals'

return {
    'sbdchd/neoformat',
    config = function()
        g.neoformat_enabled_cpp = {"uncrustify"}
        g.neoformat_enabled_javascript = {"prettierd"}
        g.neoformat_enabled_typescript = {"prettierd"}
        g.neoformat_enabled_typescriptreact = {"prettierd"}
        g.neoformat_enabled_sql = {"pg_format"}
        cmd([[
        augroup fmt
          autocmd!
          au BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
        augroup END
        ]])

        require("which-key").add({
            {"<leader>F", '<Cmd>Neoformat<CR>', desc = "Format document"}
        })
    end
}
