return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        -- Snacks Setup {{{
        vim.api.nvim_set_hl(0, "SnacksIndent", {fg = "#595959"})
        vim.api.nvim_set_hl(0, "SnacksIndentScope", {fg = "#ffc34d"})
        local config = {
            bigfile = {enabled = true},
            dashboard = {enabled = false},
            bufdelete = {enabled = true},
            explorer = {enabled = false},
            input = {enabled = true},
            picker = {enabled = true},
            notifier = {enabled = true},
            terminal = {enabled = true, terminal = {auto_close = true}},
            quickfile = {enabled = true},
            scroll = {enabled = false},
            statuscolumn = {enabled = true},
            words = {enabled = true},
            indent = {
                enabled = true,
                indent = {
                    enabled = true,
                    char = "│",
                    hl = "SnacksIndent" ---@type string|string[] hl groups for indent guides
                },
                scope = {
                    enabled = true,
                    char = "│",
                    hl = "SnacksIndentScope" ---@type string|string[] hl group for scopes

                }
            },
            scope = {enabled = true}
        }
        require('snacks').setup(config)
        -- }}}
        -- Keybindings {{{
        require("which-key").add({
            {"<leader>t", group = "Picker"},
            {
                "<leader>tb",
                function() Snacks.picker.buffers() end,
                desc = "Buffers"
            }, {"<leader>tg", group = "Git"}, {
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
            },
            {
                "<leader>tt",
                function() Snacks.picker.grep() end,
                desc = "Live grep"
            },
            {
                "<leader>tq",
                function() Snacks.picker.qflist() end,
                desc = "Quickfix list"
            }, {
                "<leader>ty",
                function() Snacks.picker.todo_comments() end,
                desc = "Find to-do marks"
            }, {
                "<leader>T",
                function() Snacks.terminal.toggle() end,
                desc = "Open vertical terminal buffer"
            }
        })
        -- }}}
    end
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
