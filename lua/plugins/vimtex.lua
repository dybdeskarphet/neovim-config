require 'globals'

return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexrun"
    end,
    config = function()
        require("which-key").add({
            {
                "<leader>L",
                "<cmd>VimtexCompile<CR>",
                desc = "Compile the current TeX file"
                --        cond = function() return vim.bo.filetype == "tex" end
            }
        })
        -- }}}
    end
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
