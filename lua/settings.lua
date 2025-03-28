require "globals"

-- Set associating between turned on plugins and filetype
cmd [[filetype plugin on]]

-- Disable comments on pressing Enter
cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- Tabs 
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Clipboard
opt.clipboard = ''
opt.fixeol = false

-- Undo
opt.undofile = true
opt.undodir = fn.expand("~/.cache/nvim_undo")

-- Searching
opt.hlsearch = true
opt.incsearch = true

-- Spellcheck
opt.spelllang = "tr"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 20

-- Search
opt.ignorecase = true
opt.joinspaces = false
opt.smartcase = true
opt.showmatch = true

-- Window
opt.splitbelow = true
opt.splitright = true

-- Window
opt.splitbelow = true
opt.splitright = true

-- Wild Menu
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Themeing
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true

-- Disable Built-in Plugins
local disabled_built_ins = {
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
    "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
    "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "matchit"
}

for _, plugin in pairs(disabled_built_ins) do g["loaded_" .. plugin] = 1 end

