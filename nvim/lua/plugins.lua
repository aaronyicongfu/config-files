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
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- 'navarasu/onedark.nvim',  -- color schemes, TODO: maybe try this: projekt0n/github-nvim-theme
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
    -- 'nvim-focus/focus.nvim',
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- outline
    'simrat39/symbols-outline.nvim',

    -- comment format
    {
        'danymat/neogen',
        config = true,
    }
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
    theme = 'catppuccin',
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

-- set up treesitter

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { 'c', 'cpp', 'python', 'bash', 'lua' },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
  },
  disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
}

require('treesitter-context').setup({
    mode = 'topline',
    multiline_threshold = 1,
})
vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline=true, special="Grey" })

-- set up outline view
local symbols_outline_opt = {
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"q"},
    show_help = "?",
  },
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "", hl = "@type" },
    Method = { icon = "ƒ", hl = "@method" },
    Property = { icon = "", hl = "@method" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "", hl = "@type" },
    Interface = { icon = "", hl = "@type" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Object = { icon = "", hl = "@type" },
    Key = { icon = "", hl = "@type" },
    Null = { icon = "", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "", hl = "@type" },
    Event = { icon = "", hl = "@type" },
    Operator = { icon = "", hl = "@operator" },
    TypeParameter = { icon = "", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  }
}
require("symbols-outline").setup(symbols_outline_opt)
