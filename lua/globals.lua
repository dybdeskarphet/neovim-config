-- Vim
cmd = vim.cmd
api = vim.api
filetype = vim.filetype
lsp = vim.lsp
fn = vim.fn
g = vim.g
opt = vim.opt
map = vim.keymap.set
delmap = vim.keymap.del

-- Keyboard
function nm(key, command) map('n', key, command, {noremap = true}) end
function im(key, command) map('i', key, command, {noremap = true}) end
function vm(key, command) map('v', key, command, {noremap = true}) end
function tm(key, command) map('t', key, command, {noremap = true}) end
