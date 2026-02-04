add({
	source = "m-pilia/vim-mediawiki",
})

later(function()
	g.vim_mediawiki_site = "wiki.archlinux.org"
	g.vim_mediawiki_browser_command = "markdown-preview \r"
end)
