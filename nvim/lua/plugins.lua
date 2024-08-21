-- Install lazy.nvim the plugin manager, if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)  -- add to neovim's runtime path

vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Specify plugins
local plugins = {
    'navarasu/onedark.nvim',  -- color schemes, TODO: maybe try this: projekt0n/github-nvim-theme
    'nvim-lua/plenary.nvim',  -- seems to be a collection of lua utility functions
    {
        'nvim-telescope/telescope.nvim',  -- fuzzy finder
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- below three work together for lsp functionality
    'neovim/nvim-lspconfig',         -- set up config so that neovim talks to lsp
    'williamboman/mason.nvim',            -- package manager to install lsp servers
    'williamboman/mason-lspconfig.nvim',  -- bridge the gap between mason and lspconfig

    -- below two work together and use language servers for formatter functionality
    'jose-elias-alvarez/null-ls.nvim',
    'jay-babu/mason-null-ls.nvim',

    -- autocompletion!
    'hrsh7th/nvim-cmp',  -- nvim-cmp core
    'hrsh7th/cmp-buffer',  -- complete from buffer
    'hrsh7th/cmp-path',  -- complete file
    'hrsh7th/cmp-nvim-lua',  -- complete lua
    'hrsh7th/cmp-nvim-lsp',  -- talks to lsp
    'saadparwaiz1/cmp_luasnip',  -- create lua snippets (TODO: find a similar plugin for cpp)

    -- git integration
    'lewis6991/gitsigns.nvim',

    -- File explorer and icons
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',


    -- statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }

    -- Hightlight word under cursor (TODO: find a useable plugin)
}

-- Specify options
local opts = {
  ui = {icons = {start = '▷ '}}
}  -- original start icon is a question mark

-- Set up plugins
require('lazy').setup(plugins, opts)

-- =========================
-- Set up individual plugins
-- =========================

require('gitsigns').setup()

-- disable netrw because we have nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors (24 bits color in TUI) to enable highlight groups
vim.opt.termguicolors = true

require('nvim-tree').setup()

-- lualine
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'buffers',
      },
    },
  },
})


