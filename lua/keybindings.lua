require "helpers/globals"
require "helpers/keyboard"

local wk = require("which-key")

-- Global {{{
wk.add({
    {"K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover information"},
    {"<leader>o", "<cmd>Telescope find_files<cr>", desc = "Find files"},
    {"<leader>w", "<c-w>", desc = "Press Ctrl-W"},
    {"T", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree"},
    {"gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to declaration"},
    {"gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references"}, {
        "<leader>T",
        "<cmd>below terminal<cr>",
        desc = "Open vertical terminal buffer"
    }
})
-- }}}

-- Clipboard {{{
wk.add({
    {
        '<leader>p',
        'o<esc>"+p',
        desc = "Paste the clipboard after the cursor",
        mode = {"v", "n"}
    }, {
        '<leader>P',
        'O<esc>"+P',
        desc = "Paste the clipboard before the cursor",
        mode = {"v", "n"}
    }, {
        '<leader>y',
        '"+y',
        desc = "Use yank options with system clipboard",
        mode = {"v", "n"}
    }
})
-- }}}

-- Move visual blocks {{{
vm("J", ":m '>+1<CR>gv=gv")
vm("K", ":m '<-2<CR>gv=gv")
-- }}}

-- LSP {{{
wk.add({
    {"<leader>l", group = "LSP", desc = ""},
    {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "Code action"
    },
    {"<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol"}
})
-- }}}

-- Telescope {{{

wk.add({
    {"<leader>t", group = "Telescope"},
    {"<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers"},
    {"<leader>tg", group = "Git"},
    {"<leader>tgb", "<cmd>Telescope git_branches<cr>", desc = "Git branches"},
    {"<leader>tgo", "<cmd>Telescope git_files<cr>", desc = "Git files"},
    {"<leader>tj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist"},
    {"<leader>to", "<cmd>Telescope find_files<CR>", desc = "Find files"},
    {"<leader>tp", "<cmd>Telescope oldfiles<cr>", desc = "Oldfiles"},
    {"<leader>tq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix list"},
    {
        "<leader>tr",
        "<cmd>Telescope resume<cr>",
        desc = "Previous Telescope window"
    }, {
        "<leader>ts",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Workspace symbols"
    }, {"<leader>tt", "<cmd>Telescope live_grep<cr>", desc = "Live grep"},
    {"<leader>ty", "<cmd>TodoTelescope<cr>", desc = "Find to-do marks"}
})
-- }}}

-- Trouble {{{
wk.add({
    {
        "<leader>x",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle trouble"
    }
})
-- }}}

-- Barbar {{{
nm("<A-,>", '<Cmd>BufferPrevious<CR>')
nm("<A-.>", '<Cmd>BufferNext<CR>')
nm("<A-c>", '<Cmd>BufferClose<CR>')
-- }}}

-- Neoformat {{{
wk.add({{"<leader>F", '<Cmd>Neoformat<CR>', desc = "Format document"}})
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
