return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "lua", "typescript", "javascript", "python", "rust", "hyprlang",
                "latex", "markdown", "csv", "html", "htmldjango", "tsx", "sql"
            },
            sync_install = true,
            highlight = {enable = true},
            indent = {enable = true}
        }

        -- For Hyprland configs
        vim.filetype.add({pattern = {[".*/hypr/.*%.conf"] = "hyprlang"}})
    end
}
