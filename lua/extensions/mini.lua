--[[
  File: mini.lua
  Description: mini.nvim plugins configuration
  See: https://github.com/echasnovski/mini.nvim?tab=readme-ov-file
]] -- Comments
-- See: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
require('mini.comment').setup()

-- Autopairs
-- See: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
require('mini.pairs').setup()

-- Starter
-- See: https://github.com/echasnovski/mini.starter
starter = require('mini.starter')
starter.setup({
    autoopen = true,
    evaluate_single = true,
    items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(10, true, false)
    },
    header = [[       __                               __              __      
      /\ \                             /\ \            /\ \__   
  ____\ \ \/'\      __     _ __   _____\ \ \___      __\ \ ,_\  
 /',__\\ \ , <    /'__`\  /\`'__\/\ '__`\ \  _ `\  /'__`\ \ \/  
/\__, `\\ \ \\`\ /\ \L\.\_\ \ \/ \ \ \L\ \ \ \ \ \/\  __/\ \ \_ 
\/\____/ \ \_\ \_\ \__/.\_\\ \_\  \ \ ,__/\ \_\ \_\ \____\\ \__\
 \/___/   \/_/\/_/\/__/\/_/ \/_/   \ \ \/  \/_/\/_/\/____/ \/__/
                                    \ \_\                       
                                     \/_/                       ]],

    footer = [[]],
    content_hooks = {
        starter.gen_hook.indexing('all', {'Builtin actions'}),
        starter.gen_hook.adding_bullet(" "),
        starter.gen_hook.aligning("center", "center")
    },
    query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
    silent = true
})
