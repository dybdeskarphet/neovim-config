MiniDeps.add({
	source = "m-pilia/vim-mediawiki",
})

MiniDeps.later(function()
	vim.g.vim_mediawiki_site = "wiki.archlinux.org"
	vim.g.vim_mediawiki_browser_command = "markdown-preview \r"
end)
