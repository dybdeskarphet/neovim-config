later(function()
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

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

	ls.add_snippets("python", {
		s("markdown", {
			t({ "# %% [markdown]", "# " }),
			i(1),
		}),
		s("python", {
			t({ "# %%", "" }),
			i(1),
		}),
	})
end)
