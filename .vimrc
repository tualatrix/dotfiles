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
autocmd FileType c set tabstop=2 shiftwidth=2 expandtab omnifunc=ccomplete#Complete
set tabstop=4
set shiftwidth=4
set expandtab

"vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

"Locate and return character "above" current cursor position...
function! LookUpwards()
python << EOF
from vim import *
row, col = current.window.cursor
s = current.buffer[row - 2][col]
current.line = current.line + s
EOF
endfunction

let g:pydiction_location = '$HOME/.vim/ftplugin/complete-dict'

"Reimplement CTRL-Y within insert mode...

nmap <silent>  <C-Y>  :call LookUpwards()<CR>

:map <F12> :!python -m pdb %<CR>
:map <C-c> "+y
:map <C-v> "+p
nmap <F2> :NERDTreeToggle<CR>.
