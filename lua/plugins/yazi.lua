return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {"folke/snacks.nvim", lazy = true},
    opts = {
        open_for_directories = false,
        keymaps = {show_help = '<f1>'},
        yazi_floating_window_border = "rounded"
    },
    config = function(_, opts)
        require("yazi").setup(opts)
        require("which-key").add({
            {"T", "<cmd>Yazi<cr>", desc = "Open yazi at the current file"}, {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory"
            }
        })
    end
}
