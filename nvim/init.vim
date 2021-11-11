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



