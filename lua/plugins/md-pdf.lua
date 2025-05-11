return {
    'arminveres/md-pdf.nvim',
    branch = 'main', -- you can assume that main is somewhat stable until releases will be made
    lazy = true,
    ---@type md-pdf.config
    opts = {
        margins = "1.5cm",
        pandoc_user_args = {
            "-V lang=tr" -- long options
        }
    }
}
