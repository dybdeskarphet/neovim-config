return {
    -- Barbar (Window bar plugin)
    'romgrk/barbar.nvim',
    dependencies = {'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'},
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
        -- Barbar Setup {{{
        require("barbar").setup({
            animation = true,
            auto_hide = false,
            tabpages = false,
            clickable = true,
            focus_on_close = 'left',
            highlight_alternate = false,
            highlight_inactive_file_icons = false,
            highlight_visible = true,
            icons = {
                buffer_index = false,
                buffer_number = false,
                button = '',
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = {
                        enabled = true,
                        icon = 'ﬀ'
                    },
                    [vim.diagnostic.severity.WARN] = {enabled = false},
                    [vim.diagnostic.severity.INFO] = {enabled = false},
                    [vim.diagnostic.severity.HINT] = {enabled = true}
                },
                gitsigns = {
                    added = {enabled = true, icon = '+'},
                    changed = {enabled = true, icon = '~'},
                    deleted = {enabled = true, icon = '-'}
                },
                filetype = {custom_colors = false, enabled = true},
                separator = {left = '▎', right = ''},
                separator_at_end = false,
                modified = {button = '●'},
                pinned = {button = '', filename = true},
                preset = 'default',
                alternate = {filetype = {enabled = false}},
                current = {buffer_index = false},
                inactive = {button = '×'},
                visible = {modified = {buffer_number = false}}
            },

            -- If true, new buffers will be inserted at the start/end of the list.
            -- Default is to insert after current buffer.
            insert_at_end = true,
            maximum_padding = 1,
            minimum_padding = 1,
            maximum_length = 30,
            minimum_length = 0,
            semantic_letters = true,
            sidebar_filetypes = {
                undotree = {
                    text = 'undotree',
                    align = 'center' -- *optionally* specify an alignment (either 'left', 'center', or 'right')
                },
                -- Or, specify all three
                Outline = {
                    event = 'BufWinLeave',
                    text = 'symbols-outline',
                    align = 'right'
                }
            },
            letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
            no_name_title = nil,
            sort = {ignore_case = true}
        })
        -- }}}
        -- Keybindings {{{
        require("which-key").add({
            {
                "<A-h>",
                "<Cmd>BufferPrevious<CR>",
                desc = "Go to the previous buffer (barbar)"
            },
            {
                "<A-l>",
                "<Cmd>BufferNext<CR>",
                desc = "Go to the next buffer (barbar)"
            },
            {
                "<A-q>",
                '<Cmd>BufferClose<CR>',
                desc = "Close the curent buffer (barbar)"
            },
            {
                "<A-1>",
                "<Cmd>BufferGoto 1<CR>",
                desc = "Go to the 1st buffer (barbar)"
            },
            {
                "<A-2>",
                "<Cmd>BufferGoto 2<CR>",
                desc = "Go to the 2nd buffer (barbar)"
            },
            {
                "<A-3>",
                "<Cmd>BufferGoto 3<CR>",
                desc = "Go to the 3rd buffer (barbar)"
            },
            {
                "<A-4>",
                "<Cmd>BufferGoto 4<CR>",
                desc = "Go to the 4th buffer (barbar)"
            },
            {
                "<A-5>",
                "<Cmd>BufferGoto 5<CR>",
                desc = "Go to the 5th buffer (barbar)"
            },
            {
                "<A-6>",
                "<Cmd>BufferGoto 6<CR>",
                desc = "Go to the 6th buffer (barbar)"
            },
            {
                "<A-7>",
                "<Cmd>BufferGoto 7<CR>",
                desc = "Go to the 7th buffer (barbar)"
            },
            {
                "<A-8>",
                "<Cmd>BufferGoto 8<CR>",
                desc = "Go to the 8th buffer (barbar)"
            },
            {
                "<A-9>",
                "<Cmd>BufferGoto 9<CR>",
                desc = "Go to the 9th buffer (barbar)"
            },
            {
                "<A-0>",
                "<Cmd>BufferLast<CR>",
                desc = "Go to the last buffer (barbar)"
            }
        })
        -- }}}
    end,
    version = '^1.0.0' -- optional: only update when a new 1.x version is released
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
