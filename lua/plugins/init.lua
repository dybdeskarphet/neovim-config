require 'globals'

return {
    -- Monokai {{{
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            require("monokai-pro").setup({
                transparent_background = false,
                devicons = true,
                styles = {
                    comment = {italic = true},
                    keyword = {italic = true}, -- any other keyword
                    type = {italic = true}, -- (preferred) int, long, char, etc
                    storageclass = {italic = true}, -- static, register, volatile, etc
                    structure = {italic = true}, -- struct, union, enum, etc
                    parameter = {italic = true}, -- parameter pass in function
                    annotation = {italic = true},
                    tag_attribute = {italic = true} -- attribute of tag in reactjs
                },
                filter = "spectrum" -- classic | octagon | pro | machine | ristretto | spectrum
            })
            cmd [[colorscheme monokai-pro-spectrum]]
        end
    }, -- }}}
    -- Yazi {{{
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        opts = {
            open_for_directories = false,
            keymaps = {show_help = '<f1>'},
            yazi_floating_window_border = "rounded"
        }
    }, -- }}}
    -- Which-key {{{
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true,
        init = function()
            opt.timeout = true
            opt.timeoutlen = 300
        end
    }, -- }}}
    -- Autotag using Treesitter {{{
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true
            },
            per_filetype = {
                -- ["html"] = {
                --   enable_close = false
                -- }
            }
        }
    }, -- }}}
    -- Indent Blank Line {{{
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {}
    }, -- }}}
    -- Colorizer {{{
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            '*', -- Highlight all files, but customize some others.
            css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
            html = {names = false},
            markdown = {names = false},
            mediawiki = {names = false}
        }
    }, -- }}}
    -- LSP Thingies {{{
    {
        "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }, -- }}}
    -- cmp-nvim-lsp {{{
    {'hrsh7th/cmp-nvim-lsp'}, -- }}} 
    -- nvim-cmp {{{
    {'hrsh7th/nvim-cmp'}, -- }}}
    -- LuaSnip {{{
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {"rafamadriz/friendly-snippets"}
    }, -- }}}
    -- LuaSnip extender for CMP {{{
    {'saadparwaiz1/cmp_luasnip'}, -- }}}
    -- LSPKind {{{
    {'onsails/lspkind.nvim'}, -- }}}
    -- Trouble {{{
    {'folke/trouble.nvim', opts = {}}, -- }}}
    -- Telescope {{{
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, -- }}}
    -- Formatter {{{
    {
        'sbdchd/neoformat',
        config = function()
            g.neoformat_enabled_cpp = {"uncrustify"}
            g.neoformat_enabled_javascript = {"prettierd"}
            g.neoformat_enabled_typescript = {"prettierd"}
            g.neoformat_enabled_typescriptreact = {"prettierd"}
            cmd([[
        augroup fmt
          autocmd!
          au BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
        augroup END
      ]])
        end
    }, -- }}}
    -- CSV View {{{
    {
        "hat0uma/csvview.nvim",
        opts = {
            view = {
                ---@type "highlight" | "border"
                display_mode = "border"
            }
        }
    }, -- }}}
    -- Easytables {{{
    {"Myzel394/easytables.nvim", opts = {}}, -- }}}
    -- Git Signs {{{
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'right_align',
                delay = 1000,
                ignore_whitespace = false
            }
        }
    }, -- }}}
    -- Markdown Preview {{{
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && yarn install",
        init = function() g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"},
        config = function()
            g.mkdp_page_title = "${name}"
            g.mkdp_browser = "markdown-preview"
        end
    }, -- }}}
    -- Markdown to PDF {{{
    {
        'arminveres/md-pdf.nvim',
        branch = 'main', -- you can assume that main is somewhat stable until releases will be made
        lazy = true,
        ---@type md-pdf.config
        opts = {margins = "0.5cm"}
    }, -- }}}
    -- Vim-Mediawiki {{{
    {
        'm-pilia/vim-mediawiki',
        config = function()
            g.vim_mediawiki_site = 'wiki.archlinux.org'
            g.vim_mediawiki_browser_command = "markdown-preview \r"
        end
    }, -- }}}
    -- stcursorword {{{
    {"sontungexpt/stcursorword", event = "VeryLazy", config = true}, -- }}
    -- Crates.nvim {{{
    {
        'saecki/crates.nvim',
        tag = 'stable',
        opts = {completion = {cmp = {enabled = true}}}
    }, -- }}}
    -- TODO Comments {{{
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
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
    -- Undotree {{{
    {'mbbill/undotree'}, -- }}}
    -- Suda.vim {{{
    {'lambdalisue/vim-suda'}, -- }}}
    -- Vimtex {{{
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            g.vimtex_view_method = "zathura"
            g.vimtex_compiler_method = "latexrun"
        end
    }, -- }}}
    -- Treesitter Refactor {{{ 
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        config = function()
            require'nvim-treesitter.configs'.setup {
                refactor = {
                    smart_rename = {
                        enable = true,
                        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                        keymaps = {smart_rename = "gsr"}
                    }
                }
            }
        end
    }, -- }}}
    -- nvim-autopairs {{{
    {'windwp/nvim-autopairs', event = "InsertEnter", config = true, opts = {}}
    -- }}}
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
