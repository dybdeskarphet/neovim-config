return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        '*', -- Highlight all files, but customize some others.
        css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
        html = {names = false},
        markdown = {names = false},
        mediawiki = {names = false},
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RGBA = true, -- #RGBA hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            AARRGGBB = true, -- 0xAARRGGBB hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true -- CSS hsl() and hsla() functions
        }
    }
}
