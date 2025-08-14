vim.lsp.config("basedpyright", {
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		basedpyright = {
			analaysis = { autoSearchPaths = true, useLibraryCodeForTypes = true },
		},
	},
})
