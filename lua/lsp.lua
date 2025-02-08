vim.opt.signcolumn = 'yes'

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local configs = require('lspconfig.configs')
local cmp = require('cmp')
local lspkind = require('lspkind')
local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local diag = vim.diagnostic

-- Mason {{{
-- Custom handlers if you want to configure your LSP yourself.
-- NOTE: You have to use the general nvim-lspconfig setup way to setup an external LSP, using Mason handlers doesn't work as far as I know.
local handlers = {
    function(server_name) -- default handler (optional)
        if server_name == "tsserver" then server_name = "ts_ls" end
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig[server_name].setup({capabilities = capabilities})
    end,
    -- basedpyrgiht has type checker set to "recommended" by default and it creates a lot of LSP warnings, turn it to "recommended" if you're working on a project that should have strict typing.
    -- ["basedpyright"] = function()
    --     lspconfig.basedpyright.setup {
    --         settings = {
    --             basedpyright = {
    --                 analysis = {
    --                     autoSearchPaths = true,
    --                     typeCheckingMode = "standard"

    --                 }
    --             }
    --         }
    --     }
    -- end
    ["pylsp"] = function()
        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {ignore = {'W391'}, maxLineLength = 100}
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

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls", "pylsp", "rust_analyzer", "marksman", "jsonls", "ts_ls",
        "cssls", "bashls", "texlab", "hyprls", "html"
    },
    handlers = handlers
});
-- }}}

-- Other LSP Configurations {{{
-- Custom Django LSP
lspconfig.djlsp.setup {
    cmd = {"djlsp"},
    filetypes = {"htmldjango", "html"},
    init_options = {djlsp = {}}
}

-- Crates LSP 
-- WARN: Needs Crates.nvim to work
require("crates").setup {
    lsp = {
        enabled = true,
        on_attach = function(client, bufnr)
            -- the same on_attach function as for your other lsp's
        end,
        actions = true,
        completion = true,
        hover = true
    }
}
-- }}}

-- Snippet Configuration {{{
-- Load VSCode snippets 
-- WARN: Needed for friendly-snippets to work (Python snippets etc.)
require("luasnip.loaders.from_vscode").lazy_load()

-- Add HTML snippets to htmldjango files
ls.filetype_extend("htmldjango", {"html"})
-- }}}

-- VBA Snippets {{{
ls.add_snippets("vb", {
    s("If", fmt([[
    If {} Then
        {}
    End If
    ]], {i(1), i(2)})), s("ElseIf", fmt([[
    ElseIf {} Then
        {}
    ]], {i(1), i(2)})), s("Else", fmt([[
    Else
        {}
    ]], {i(1)})), s("Sub", fmt([[
    Sub {}()
        {}
    End Sub
    ]], {i(1), i(2)})), s("Function", fmt([[
    Function {}()
        {}
    End Function
    ]], {i(1), i(2)}))
})
-- }}}

-- Completion {{{
cmp.setup {
    snippet = {
        expand = function(args) require'luasnip'.lsp_expand(args.body) end
    },

    completion = {completeopt = 'menu,menuone,noinsert,noselect'},
    preselect = cmp.PreselectMode.None,

    mapping = {
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),

        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(), -- Abort completion
            c = cmp.mapping.close() -- Close completion window
        }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'})
    },

    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, -- LSP
        {name = 'nvim_lsp_signature_help'}, -- LSP for parameters in functions
        {name = 'nvim_lua'}, -- Lua Neovim API
        {name = 'luasnip'}, -- LuaSnip
        {name = 'buffer'}, -- Buffers
        {name = 'path'} -- Paths
    }, {}),

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = {
                menu = function()
                    return math.floor(0.45 * vim.o.columns)
                end,
                abbr = function()
                    return math.floor(0.45 * vim.o.columns)
                end
            },
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end
        })
    }
} -- }}}

-- Configure signs {{{
local signs = {Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " "}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
-- }}}

-- Don't show virtual text if it's not at least a WARN {{{
diag.config({
    underline = {severity = {max = diag.severity.INFO}},
    virtual_text = {severity = {min = diag.severity.WARN}}
})
-- }}}

-- Change indent according to the file {{{
-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    command = "setlocal shiftwidth=4 tabstop=4"
})
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
