-- Ref: https://martinlwx.github.io/en/config-neovim-from-scratch/#the-basics
-- Hint: see `:h vim.keymap.set()`

-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = false,      -- do show message
}

-- append a description to the global options
local function add_desc(opts_, description)
  opts_ = opts_ or {}  -- Ensure opts is a table if nil is passed
  local opts_c = {}
  for k, v in pairs(opts_) do
    opts_c[k] = v
  end
  opts_c.desc = description
  return opts_c
end

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
vim.keymap.set('n', '<leader>ff', builtin.find_files, add_desc(opts, 'find files'))
vim.keymap.set('n', '<leader>fg', builtin.live_grep, add_desc(opts, 'grep'))
vim.keymap.set('n', '<leader>fb', builtin.buffers, add_desc(opts, 'grep buffers'))
vim.keymap.set('n', '<leader>fh', builtin.help_tags, add_desc(opts, 'help tags'))
builtin = nil

-- move between buffers
vim.keymap.set('n', 'th', ':BufferPrevious<Enter>', opts)
vim.keymap.set('n', 'tj', ':BufferPrevious<Enter>', opts)
vim.keymap.set('n', 'tk', ':BufferNext<Enter>', opts)
vim.keymap.set('n', 'tl', ':BufferNext<Enter>', opts)

-- move between tabs
vim.keymap.set('n', 'tn', ':tabnext<Enter>', opts)
vim.keymap.set('n', 'tp', ':tabprevious<Enter>', opts)

-- go to definition/declaration by LSP
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<Enter>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<Enter>", opts)

-- open/close nvim-tree (´ is shift + option + e on Mac)
vim.keymap.set("n", "´", ":NvimTreeToggle<Enter>", opts)

-- perform the forward/backward search without jump
vim.keymap.set("n", "*", "*``", opts)
vim.keymap.set("n", "#", "#``", opts)

-- jump between tabs
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- symbol outline
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", add_desc(opts, "toggle outline"))
vim.keymap.set("n", "<leader>p", "<cmd>AerialNavToggle<CR>", add_desc(opts, "nav outline"))

-- Close alll inactive buffers
vim.keymap.set("n", "<leader>ww", function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Check if the buffer is listed and not displayed in any window
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.fn.bufwinnr(bufnr) == -1 then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end, { desc = "Close all inactive buffers" })
