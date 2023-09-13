local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "folke/neodev.nvim",
    {
        "tiagovla/tokyodark.nvim",
        opts = {
            transparent_background = true,
        },
        config = function(_, opts)
            require("tokyodark").setup(opts)
            vim.cmd [[colorscheme tokyodark]]
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = false,
        config = function()
            require("configs.telescope")
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("configs.neotree")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("configs.treesitter")
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },                                                                -- Required
            { 'williamboman/mason.nvim' },                                                              -- Optional
            { 'williamboman/mason-lspconfig.nvim' },                                                    -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                                                                     -- Required
            { 'hrsh7th/cmp-nvim-lsp' },                                                                 -- Required
            { 'L3MON4D3/LuaSnip',                 dependencies = { "rafamadriz/friendly-snippets" }, }, -- Required
        },
        config = function()
            require("configs.lsp")
        end

    },
    {
        'mbbill/undotree',
        config = function()
            require("configs.undotree")
        end
    },
    {
        'ThePrimeagen/harpoon',
        config = function()
            require("configs.harpoon")
        end
    },
    {
        'jbyuki/venn.nvim',
        config = function()
            require("configs.venn")
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        version = '^1.0.0',
        config = function()
            require("configs.barbar")
        end

    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.gitsigns")
        end
    },
    {
        'feline-nvim/feline.nvim',
        branch = "0.5-compat",
        config = function()
            require("configs.feline")
        end
    },
    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    },
    { 'ThePrimeagen/vim-be-good' }
})
