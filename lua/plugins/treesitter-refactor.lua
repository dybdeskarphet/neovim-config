return {
    "nvim-treesitter/nvim-treesitter-refactor",
    config = function()
        require'nvim-treesitter.configs'.setup {
            refactor = {
                smart_rename = {
                    enable = true,
                    -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                    keymaps = {smart_rename = "gsr"}
                }
            }
        }
    end
}
