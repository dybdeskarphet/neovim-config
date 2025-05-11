return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        '*', -- Highlight all files, but customize some others.
        css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
        html = {names = false},
        markdown = {names = false},
        mediawiki = {names = false}
    }
}
