--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]] require "helpers/globals"

return {
    -- Mason {{{
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"
        },
        config = function() require "extensions.mason" end
    }, -- }}}
    -- Which key {{{
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    }, -- }}}
    -- Neo Tree {{{
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        },
        config = function() require "extensions.neotree" end
    }, -- }}}
    -- Telescope {{{
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        lazy = false,
        dependencies = {"nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim"},
        config = function() require "extensions.telescope" end
    }, -- }}}
    -- CMP {{{
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-nvim-lua',
            'rafamadriz/friendly-snippets'
        },
        config = function() require "extensions.cmp" end
    }, -- }}}
    -- LSP Kind {{{
    {
        'onsails/lspkind-nvim',
        lazy = true,
        config = function() require "extensions.lspkind" end
    }, -- }}}
    -- Git Signs{{{
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        config = function() require "extensions.gitsigns" end
    }, -- }}}
    -- Trouble {{{
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function() require "extensions.trouble" end
    }, -- }}}
    -- TreeSitter {{{
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        event = {"BufReadPost", "BufNewFile"},
        config = function() require "extensions.treesitter" end
    }, -- }}}
    -- Theme: Monokai Pro {{{
    {
        "loctvl842/monokai-pro.nvim",
        config = function() require "extensions.monokai" end
    }, -- }}}
    -- Mini.nvim {{{ 
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function() require("extensions.mini") end
    }, -- }}}
    -- Markdown Preview {{{
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && yarn install",
        config = function() require("extensions.mdpreview") end,
        init = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    }, -- }}}
    -- Rust.vim {{{
    {"rust-lang/rust.vim", ft = {"rust"}}, -- }}}
    -- Crates.nvim {{{
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function() require('crates').setup() end
    }, -- }}}
    -- Barbar {{{
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0' -- optional: only update when a new 1.x version is released
    }, -- }}}
    -- Lualine {{{
    {
        'nvim-lualine/lualine.nvim',
        config = function() require("extensions.lualine") end,
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, -- }}}
    -- Autosave {{{
    {
        "https://git.sr.ht/~nedia/auto-save.nvim",
        event = {"BufReadPre"},
        opts = {
            events = {'InsertLeave', 'BufLeave'},
            silent = false,
            exclude_ft = {'neo-tree'}
        }
    }, -- }}}
    -- Blankline {{{
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function() require("extensions.blankline") end
    }, -- }}}
    -- stcursorword {{{
    {"sontungexpt/stcursorword", event = "VeryLazy", config = true}, -- }}}
    -- Cord {{{
    {
        'vyfor/cord.nvim',
        build = './build || .\\build',
        event = 'VeryLazy',
        opts = {} -- calls require('cord').setup()
    }, -- }}}
    -- Neoformat {{{
    {
        'sbdchd/neoformat',
        config = function() require("extensions.neoformat") end
    }, -- }}}
    -- Vim-Mediawiki {{{
    {
        'm-pilia/vim-mediawiki',
        config = function() require("extensions.mediawiki") end
    }, -- }}}
    -- Colorizer {{{
    {
        'norcalli/nvim-colorizer.lua',
        init = function() require'colorizer'.setup() end
    }, -- }}}
    -- Todo Comments {{{
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    }, -- }}}
    -- todotxt {{{
    {'freitass/todo.txt-vim'} -- }}}

}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0

