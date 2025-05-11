return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {"folke/snacks.nvim", lazy = true},
    opts = {
        open_for_directories = false,
        keymaps = {show_help = '<f1>'},
        yazi_floating_window_border = "rounded"
    }
}
