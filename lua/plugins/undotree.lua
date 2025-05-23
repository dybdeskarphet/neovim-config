return {
    'mbbill/undotree',
    config = function()
        require("which-key").add({
            {"<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Open Undotree"}
        })
    end
}
