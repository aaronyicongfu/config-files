" Load vim config
source ~/.vimrc
" We want to use vim-plug to manage the plugins for neovim,
" the following code automates installation of vim-plug:
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify the plug-ins you need in the following section
" with the convention: github-username/github-reponame:
" Every time new plug-in is added, run :PlugInstall to install
call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'  " Ctrl-p fuzzy finder
Plug 'airblade/vim-gitgutter'  " Show git diff
Plug 'preservim/nerdtree'  " File explorer
Plug 'jistr/vim-nerdtree-tabs'  " Keep NERDTree when switching tabs
Plug 'Xuyuanp/nerdtree-git-plugin'  " Show git info in nerdtree
"Plug 'neovim/nvim-lspconfig'  " config for nvim's Language Server Protocol
"Plug 'hrsh7th/nvim-cmp'  " General-purpose autocompletion, recommended by nvim-lspconfig
"Plug 'hrsh7th/cmp-buffer'  " nvim-cmp source for buffer words
Plug 'dense-analysis/ale'  " seems to be the ultimate autocompletion solution?
call plug#end()

" Write swap file to disk every 100ms, this is to accelerate
" gitgutter
set updatetime=100

" [gitgutter]
" Do not use any key mapping
let g:gitgutter_map_keys = 0
" colors
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

" [nerdtree-tabs]
" Open the tree and persist tabs by default
let g:nerdtree_tabs_open_on_console_startup=1

" [cmp-buffer]
"lua << EOF
"require'cmp'.setup {
"  sources = {
"    { name = 'buffer' }
"  }
"}
"EOF

" [ALE]
" to install flake8 and black, need do: pip install flake8 black
" to install pyright, need do: sudo npm install -g pyright
let g:ale_linters = {'python':['flake8', 'pyright']}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['black']
\  }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
