require 'globals'
local wk = require("which-key")
local ls = require("luasnip")

-- Global
wk.add({
    {"K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover information"},
    {"<leader>o", function() Snacks.picker.smart() end, desc = "Find files"},
    {"<leader>w", "<c-w>", desc = "Press Ctrl-W"},
    {"T", "<cmd>Yazi<cr>", desc = "Open yazi at the current file"}, {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory"
    },
    {"gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to declaration"},
    {
        "<leader>T",
        function() Snacks.terminal.toggle() end,
        desc = "Open vertical terminal buffer"
    }, {"<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Open Undotree"}
})

-- Clipboard
wk.add({
    {
        '<leader>p',
        '<esc>"+p',
        desc = "Paste the clipboard after the cursor",
        mode = {"v", "n"}
    }, {
        '<leader>P',
        '<esc>"+P',
        desc = "Paste the clipboard before the cursor",
        mode = {"v", "n"}
    }, {
        '<leader>y',
        '"+y',
        desc = "Use yank options with system clipboard",
        mode = {"v", "n"}
    }
})

-- Barbar
wk.add({
    {
        "<A-h>",
        "<Cmd>BufferPrevious<CR>",
        desc = "Go to the previous buffer (barbar)"
    },
    {"<A-l>", "<Cmd>BufferNext<CR>", desc = "Go to the next buffer (barbar)"},
    {"<A-q>", '<Cmd>BufferClose<CR>', desc = "Close the curent buffer (barbar)"},
    {"<A-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to the 1st buffer (barbar)"},
    {"<A-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to the 2nd buffer (barbar)"},
    {"<A-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to the 3rd buffer (barbar)"},
    {"<A-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to the 4th buffer (barbar)"},
    {"<A-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to the 5th buffer (barbar)"},
    {"<A-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to the 6th buffer (barbar)"},
    {"<A-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to the 7th buffer (barbar)"},
    {"<A-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to the 8th buffer (barbar)"},
    {"<A-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to the 9th buffer (barbar)"},
    {"<A-0>", "<Cmd>BufferLast<CR>", desc = "Go to the last buffer (barbar)"}
})

-- Picker
wk.add({
    {"<leader>t", group = "Picker"},
    {"<leader>tb", function() Snacks.picker.buffers() end, desc = "Buffers"},
    {"<leader>tg", group = "Git"}, {
        "<leader>tgb",
        function() Snacks.picker.git_branches() end,
        desc = "Git branches"
    },
    {
        "<leader>tgo",
        function() Snacks.picker.git_files() end,
        desc = "Git files"
    },
    {
        "<leader>to",
        function() Snacks.picker.smart() end,
        desc = "Smart find files"
    }, {"<leader>tt", function() Snacks.picker.grep() end, desc = "Live grep"},
    {
        "<leader>tq",
        function() Snacks.picker.qflist() end,
        desc = "Quickfix list"
    }, {
        "<leader>ty",
        function() Snacks.picker.todo_comments() end,
        desc = "Find to-do marks"
    }
})

-- LSP
wk.add({
    {"<leader>l", group = "LSP", desc = ""},
    {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "Code action"
    },
    {"<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol"},
    {
        "<leader>li",
        '<cmd>lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>',
        desc = "Get information about currently running LSPs"
    }
})

-- Trouble
wk.add({
    {
        "<leader>x",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle trouble"
    }
})

-- Spellcheck 
wk.add({
    {"<leader>s", group = "Spellcheck"},
    {"<leader>ss", "<cmd>set spell<cr>", desc = "Enable Turkish spellcheck"},
    {"<leader>su", "<cmd>set nospell<cr>", desc = "Disable Turkish spellcheck"}
})

-- Markdown
wk.add({
    {"<leader>m", group = "Markdown", desc = ""},
    {"<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Preview markdown file"},
    {
        "<leader>mc",
        function() require("md-pdf").convert_md_to_pdf() end,
        desc = "Convert markdown file to PDF"
    }
})

-- LaTeX
wk.add({
    {
        "<leader>L",
        "<cmd>VimtexCompile<CR>",
        desc = "Compile the current TeX file"
        --        cond = function() return vim.bo.filetype == "tex" end
    }
})

-- LuaSnip
map({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
map({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

-- Neoformat
wk.add({{"<leader>F", '<Cmd>Neoformat<CR>', desc = "Format document"}})

-- Move visual blocks
vm("K", ":m '<-2<CR>gv=gv")
vm("J", ":m '>+1<CR>gv=gv")

-- Keybindings for convenience
map('n', '<esc><esc>', ":noh<cr>", {noremap = true, silent = true})
nm("s", "<Nop>")
