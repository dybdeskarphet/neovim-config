--[[
  File: neotree.lua
  Description: Plugin to manage the file system and other tree like structures.
  See: https://github.com/nvim-neo-tree/neo-tree.nvim
]] local neotree = require("neo-tree")

neotree.setup({
    close_if_last_window = true,
    default_component_configs = {
        name = {
            trailing_slash = true,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName"
        }
    },
    window = {width = 50, mappings = {["l"] = "open", ["h"] = "close_node"}},
    filesystem = {
        follow_current_file = {enabled = true},
        use_libuv_file_watcher = true
    }
})
