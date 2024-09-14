--[[
  File: neoformat.lua
  Description: A plugin for formatting code
  See: https://github.com/sbdchd/neoformat
]] require 'helpers/globals'

-- Format after save
cmd([[
  augroup fmt
    autocmd!
    au BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
  augroup END
]])
