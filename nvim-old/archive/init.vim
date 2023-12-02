" This is the config file for neovim

" Note: this file goes to stdpath('config'), which
" will ususally be ~/.config/nvim

" Load legacy vimrc config file
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc " Use vim-plug to manage plugins

" Plug
" https://github.com/junegunn/vim-plug
" Auto install vim-plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')

" Plugins go here
Plug 'kien/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'

" Initialize plugin system
call plug#end() 

" You can add new plugins to the list above and run
" :PlugInstall to install them (which is really just download
" the repo from github or so)

" Set up python language server: pyright
" pyright is installed via: npm install -g pyright
" lua require'lspconfig'.pyright.setup{}

" Set up C/C++ language server

" LSP config (the mappings used in the default file don't quite work right)
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" auto-format (pyright doesn't support formatting?)
" autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

" Config compe
" luafile $HOME/.config/nvim/compe-config.lua


