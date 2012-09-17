syntax enable
colorscheme tango

set hlsearch

if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

set grepprg=grep\ -nH\ $*
set helplang=cn
set encoding=utf-8
"set tw=79 "Well, it's too annoying.
"set et
"retab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab omnifunc=pythoncomplete#Complete
autocmd FileType c set tabstop=2 shiftwidth=2 expandtab omnifunc=ccomplete#Complete
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */etc/init.d/* set ft=sh

set tabstop=4
set shiftwidth=4
set expandtab

:map <F12> :!python -m pdb %<CR>
":map <C-c> "+y
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
:map <C-v> "+p
nmap <F2> :NERDTreeToggle<CR>.

set list
set listchars=tab:▸\ ,eol:¬

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'git@github.com:tualatrix/vim-snipmate'
Bundle 'git@github.com:tualatrix/snipmate-snippets'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-coffee-script'
Bundle 'nginx.vim'
Bundle 'ctrlp.vim'
Bundle 'ack.vim'
Bundle 'rstacruz/sparkup'
Bundle 'groenewege/vim-less'
Bundle 'The-NERD-tree'
Bundle 'jsbeautify'
Bundle 'matchit.zip'
Bundle 'ZenCoding.vim'
Bundle 'CCTree'
Bundle 'minibufexpl.vim'
Bundle 'bufexplorer.zip'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'jade.vim'

filetype indent on
filetype plugin indent on     " required!

" Set this toggle to make code paste more easily
set pastetoggle=<F7>

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

nmap <F8> :TagbarToggle<CR>

" session
nmap SSA :wa<CR>:mksession! ~/sessions/
nmap SO :wa<CR>:so ~/sessions/
