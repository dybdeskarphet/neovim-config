require 'globals'

return {
    "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    build = "cd app && yarn install",
    init = function() g.mkdp_filetypes = {"markdown"} end,
    ft = {"markdown"},
    config = function()
        g.mkdp_page_title = "${name}"
        g.mkdp_browser = "markdown-preview"
    end
}
