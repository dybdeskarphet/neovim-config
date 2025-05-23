require 'globals'

return {
    "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    build = "cd app && yarn install",
    init = function() g.mkdp_filetypes = {"markdown"} end,
    ft = {"markdown"},
    config = function()
        g.mkdp_page_title = "${name}"
        g.mkdp_browser = "brave"

        require("which-key").add({
            {"<leader>m", group = "Markdown", desc = ""},
            {
                "<leader>mp",
                "<cmd>MarkdownPreview<CR>",
                desc = "Preview markdown file"
            }, {
                "<leader>mc",
                function() require("md-pdf").convert_md_to_pdf() end,
                desc = "Convert markdown file to PDF"
            }
        })
    end
}
