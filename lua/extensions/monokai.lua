--[[
  File: monokai.lua
  Description: Monokai Pro theme
  See: https://github.com/loctvl842/monokai-pro.nvim
]] local monokaipro = require("monokai-pro")
require 'helpers/globals'

monokaipro.setup({
    transparent_background = false,
    devicons = true, -- highlight the icons of `nvim-web-devicons`
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

cmd([[colorscheme monokai-pro]])

