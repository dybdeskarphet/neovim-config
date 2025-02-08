return {
    -- Barbar (Window bar plugin)
    'romgrk/barbar.nvim',
    dependencies = {'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'},
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
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
                [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
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
    },
    version = '^1.0.0' -- optional: only update when a new 1.x version is released
}
