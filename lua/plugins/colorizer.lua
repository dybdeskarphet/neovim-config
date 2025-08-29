MiniDeps.add({
	source = "catgoose/nvim-colorizer.lua",
})

MiniDeps.later(function()
	require("colorizer").setup({
		filetypes = {
			"*",
		},
		user_default_options = {
			RGB = true, -- #RGB hex codes
			RGBA = true, -- #RGBA hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			css_fn = true,
			names = false,
		},
	})
end)
