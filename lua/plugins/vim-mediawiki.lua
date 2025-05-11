require 'globals'

return {
    'm-pilia/vim-mediawiki',
    config = function()
        g.vim_mediawiki_site = 'wiki.archlinux.org'
        g.vim_mediawiki_browser_command = "markdown-preview \r"
    end
}
