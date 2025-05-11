return {
    "loctvl842/monokai-pro.nvim",
    config = function()
        require("monokai-pro").setup({
            transparent_background = false,
            devicons = true,
            styles = {
                comment = {italic = true},
                keyword = {italic = true}, -- any other keyword
                type = {italic = true}, -- (preferred) int, long, char, etc
                storageclass = {italic = true}, -- static, register, volatile, etc
                structure = {italic = true}, -- struct, union, enum, etc
                parameter = {italic = true}, -- parameter pass in function
                annotation = {italic = true},
                tag_attribute = {italic = true} -- attribute of tag in reactjs
            },
            filter = "spectrum" -- classic | octagon | pro | machine | ristretto | spectrum
        })
        vim.cmd [[colorscheme monokai-pro-spectrum]]
    end
}
