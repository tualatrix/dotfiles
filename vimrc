colorscheme tango

syntax on
set hlsearch

filetype indent on
filetype plugin indent on
filetype on

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

:map <F12> :!python -m pdb %
:map <C-c> "+y
:map <C-v> "+p
