--[[
  File: treesitter.lua
  Description: Configuration of tree-sitter
  See: https://github.com/tree-sitter/tree-sitter
]] require'nvim-treesitter.configs'.setup {

    -- Needed parsers
    ensure_installed = {
        "lua", "typescript", "javascript", "python", "rust", "hyprlang"
    },

    -- Install all parsers synchronously
    sync_install = false,

    -- Подсветка
    highlight = {
        -- Enabling highlight for all files
        enable = true,
        disable = {}
    },

    indent = {
        -- Disabling indentation for all files
        enable = false,
        disable = {}
    }
}

-- For Hyprland configs
vim.filetype.add({pattern = {[".*/hypr/.*%.conf"] = "hyprlang"}})
