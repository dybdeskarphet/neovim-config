require 'globals'

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    init = function()
        vim.opt.timeout = true
        vim.opt.timeoutlen = 100
    end,
    config = function(_, opts)
        -- Global {{{
        require("which-key").setup(opts)
        local wk = require("which-key")
        wk.add({{"<leader>w", "<c-w>", desc = "Press Ctrl-W"}})
        -- }}}
        -- Clipboard {{{
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
        -- }}}
        -- Spellcheck {{{
        wk.add({
            {"<leader>s", group = "Spellcheck"},
            {
                "<leader>ss",
                "<cmd>set spell<cr>",
                desc = "Enable Turkish spellcheck"
            },
            {
                "<leader>su",
                "<cmd>set nospell<cr>",
                desc = "Disable Turkish spellcheck"
            }
        })
        -- }}}
        -- Move visual blocks {{{
        vm("K", ":m '<-2<CR>gv=gv")
        vm("J", ":m '>+1<CR>gv=gv")
        -- }}}
        -- Keybindings for convenience {{{
        map('n', '<esc><esc>', ":noh<cr>", {noremap = true, silent = true})
        nm("s", "<Nop>")
        -- }}}
    end
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
