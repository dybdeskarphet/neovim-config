return {
    'folke/trouble.nvim',
    opts = {},
    config = function(_, opts)
        require("trouble").setup(opts)
        require("which-key").add({
            {
                "<leader>x",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Toggle trouble"
            }
        })
    end
}
