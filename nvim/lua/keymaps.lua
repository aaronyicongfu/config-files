-- Ref: https://martinlwx.github.io/en/config-neovim-from-scratch/#the-basics
-- Hint: see `:h vim.keymap.set()`

-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = false,      -- do show message
}

-----------------
-- Normal mode --
-----------------

-- Better window splitting:
-- use tmux-like keymapping (prefix + |-) to split vertically and horizontally
vim.keymap.set('n', '<C-w>|', ':vsplit<Enter>', opts)
vim.keymap.set('n', '<C-w>-', ':split<Enter>', opts)

-- Better window navigation: use CTRL + hjkl to navigate between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Plugin: telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, opts)
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
builtin = nil

-- move between buffers
vim.keymap.set('n', 'th', ':bprevious<Enter>', opts)
vim.keymap.set('n', 'tj', ':bprevious<Enter>', opts)
vim.keymap.set('n', 'tk', ':bnext<Enter>', opts)
vim.keymap.set('n', 'tl', ':bnext<Enter>', opts)

-- move between tabs
vim.keymap.set('n', 'tn', ':tabnext<Enter>', opts)
vim.keymap.set('n', 'tp', ':tabprevious<Enter>', opts)

-- go to definition/declaration by LSP
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<Enter>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<Enter>", opts)
