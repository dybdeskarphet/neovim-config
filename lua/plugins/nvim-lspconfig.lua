return {
    'neovim/nvim-lspconfig',
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.djlsp.setup {
            cmd = {"djlsp"},
            filetypes = {"htmldjango", "html"},
            init_options = {djlsp = {}}
        }
    end
}
