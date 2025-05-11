require "globals"
local diag = vim.diagnostic

-- Set associating between turned on plugins and filetype
cmd [[filetype plugin on]]

-- Disable comments on pressing Enter
-- cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- Tabs  {{{
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
-- }}}

-- Clipboard {{{
opt.clipboard = ''
opt.fixeol = false
-- }}}

-- Undo {{{
opt.undofile = true
opt.undodir = fn.expand("~/.cache/nvim_undo")
-- }}}

-- Searching {{{
opt.hlsearch = true
opt.incsearch = true
-- }}}

-- Spellcheck {{{
opt.spelllang = "tr"
-- }}}

-- Folding {{{
opt.foldmethod = "expr"
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 20
-- }}}

-- Search {{{
opt.ignorecase = true
opt.joinspaces = false
opt.smartcase = true
opt.showmatch = true
-- }}}

-- Window {{{
opt.splitbelow = true
opt.splitright = true
-- }}}

-- Wild Menu {{{
opt.wildmenu = true
opt.wildmode = "longest:full,full"
-- }}}

-- Themeing {{{
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
-- }}}

-- Disable Built-in Plugins {{{
local disabled_built_ins = {
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
    "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
    "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "matchit"
}
-- }}}

-- Diagnostics {{{
diag.config({
    underline = {severity = {max = diag.severity.INFO}},
    virtual_text = {severity = {min = diag.severity.WARN}},
    signs = {
        text = {
            [diag.severity.HINT] = "󰌶",
            [diag.severity.ERROR] = "󰅚",
            [diag.severity.INFO] = "",
            [diag.severity.WARN] = "󰀪"
        }
    }
})
-- }}}

-- Change indent according to the file {{{
-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    command = "setlocal shiftwidth=4 tabstop=4"
})
-- }}}

-- Set filetype with extension
filetype.add({pattern = {['.*.rasi'] = 'rasi'}})

for _, plugin in pairs(disabled_built_ins) do g["loaded_" .. plugin] = 1 end

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
