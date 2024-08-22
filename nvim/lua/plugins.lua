-- Install lazy.nvim the plugin manager, if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git',
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
    'L3MON4D3/LuaSnip',  -- lua snippet engine, required for autocompleting snippets
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    -- git integration
    'lewis6991/gitsigns.nvim',

    -- File explorer and icons
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',

    -- statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- trim trailing whitespace
    'cappyzawa/trim.nvim',

    -- comment code
    'numToStr/Comment.nvim',

    -- auto-focus by resizing focused pane
    'nvim-focus/focus.nvim',
}

-- Specify options
local opts = {
  ui = {icons = {start = '▷ '}}
}  -- original start icon is a question mark

-- Set up plugins
require('lazy').setup(plugins, opts)

-- ==============================
-- Set up some individual plugins
-- ==============================

require('gitsigns').setup()

-- disable netrw because we have nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors (24 bits color in TUI) to enable highlight groups
vim.opt.termguicolors = true

-- set up nvim-tree
require('nvim-tree').setup()

-- set up lualine
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

-- set up trim trailing whitespace
require('trim').setup()

-- set up commenter
require('Comment').setup()

-- set up auto-focus and disable it for tree buffer:
-- https://github.com/nvim-focus/focus.nvim?tab=readme-ov-file#disabling-focus
require('focus').setup()
local ignore_filetypes = { 'neo-tree' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup =
    vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
        then
            vim.w.focus_disable = true
        else
            vim.w.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for BufType',
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for FileType',
})
