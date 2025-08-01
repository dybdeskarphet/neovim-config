return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        heading = {
            enabled = true,
            sign = true,
            position = 'inline',
            icons = {'󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 '},
            signs = {' '},
            width = 'block', -- full, block
            left_margin = 0,
            left_pad = 3,
            right_pad = 3,
            min_width = 0,
            border = true,
            border_virtual = false,
            border_prefix = false,
            above = '▄',
            below = '▀',
            backgrounds = {
                'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg',
                'RenderMarkdownH3Bg', 'RenderMarkdownH4Bg',
                'RenderMarkdownH5Bg', 'RenderMarkdownH6Bg'
            },
            -- The 'level' is used to index into the list using a clamp
            -- Highlight for the heading and sign icons
            foregrounds = {
                'RenderMarkdownH1', 'RenderMarkdownH2', 'RenderMarkdownH3',
                'RenderMarkdownH4', 'RenderMarkdownH5', 'RenderMarkdownH6'
            }
        },
        bullet = {
            -- Turn on / off list bullet rendering
            enabled = true,
            -- Replaces '-'|'+'|'*' of 'list_item'
            -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
            -- If a function is provided both of these values are passed in using 1 based indexing
            -- If a list is provided we index into it using a cycle based on the level
            -- If the value at that level is also a list we further index into it using a clamp based on the index
            -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
            icons = {'', '', '', ''},
            -- Replaces 'n.'|'n)' of 'list_item'
            -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
            -- If a function is provided both of these values are passed in using 1 based indexing
            -- If a list is provided we index into it using a cycle based on the level
            -- If the value at that level is also a list we further index into it using a clamp based on the index
            -- Padding to add to the left of bullet point
            ordered_icons = function(ctx)
                local value = vim.trim(ctx.value)
                local index = tonumber(value:sub(1, #value - 1))
                return ('%d.'):format(index > 1 and index or ctx.index)
            end,
            left_pad = 0,
            -- Padding to add to the right of bullet point
            right_pad = 0,
            -- Highlight for the bullet icon
            highlight = 'RenderMarkdownBullet'
        },
        checkbox = {
            enabled = true,
            --  inline:  underlying text is concealed resulting in a left aligned icon
            --  overlay: result is left padded with spaces to hide any additional text
            position = 'inline',
            unchecked = {
                icon = '󰄱 ',
                highlight = 'RenderMarkdownUnchecked',
                scope_highlight = nil
            },
            checked = {
                icon = '󰱒 ',
                highlight = 'RenderMarkdownChecked',
                --   'raw':             Matched against the raw text of a 'shortcut_link'
                --   'rendered':        Replaces the 'raw' value when rendering
                --   'highlight':       Highlight for the 'rendered' icon
                --   'scope_highlight': Highlight for item associated with custom checkbox
                custom = {
                    todo = {
                        raw = '[-]',
                        rendered = '󰥔 ',
                        highlight = 'RenderMarkdownTodo',
                        scope_highlight = nil
                    }
                }
            }

        }
    },
    config = function(_, opts)
        vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg',
                            {bg = '#2F2024', fg = '#ffffff', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg',
                            {bg = '#2F251E', fg = '#ffffff', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg',
                            {bg = '#222C24', fg = '#ffffff', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg',
                            {bg = '#292e3d', fg = '#ffffff', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg',
                            {bg = '#2F2024', fg = '#ffffff', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownUnchecked',
                            {fg = '#E84F4F', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownChecked',
                            {fg = '#83C984', bold = true})
        vim.api.nvim_set_hl(0, 'RenderMarkdownBullet',
                            {fg = '#fcba03', bold = true})
        require("render-markdown").setup(opts)
    end
}
