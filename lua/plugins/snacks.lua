return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    config = function()
        vim.api.nvim_set_hl(0, "SnacksIndent", {fg = "#595959"})
        vim.api.nvim_set_hl(0, "SnacksIndentScope", {fg = "#ffc34d"})
        require('snacks').setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
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
        })
    end
}
