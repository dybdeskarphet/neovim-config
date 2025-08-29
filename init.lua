-- Import settings.lua
require("settings")

-- Bootstrap mini.nvim
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- Full control over plugin files
local plugin_files = {
	"ui.lua",
	-- "which-key.lua",
	"lsp.lua",
	"treesitter.lua",
	"blink.lua",
	"autosave.lua",
	"beacon.lua",
	"colorizer.lua",
	"creates.lua",
	"csvview.lua",
	"git.lua",
	"latex.lua",
	"markdown.lua",
	"mediawiki.lua",
	"mini.lua",
	"pick.lua",
	"undotree.lua",
	"yazi.lua",
}

for _, file in ipairs(plugin_files) do
	dofile(plugins_path .. "/" .. file)
end
