syntax enable
colorscheme tango

"incsearch is something like live search
set incsearch
" ignorecase and smartcase: /foo matches foo and fOo, /Foo only matches Foo
set ignorecase
set smartcase
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

if filereadable("/etc/issue.net")
    :map <C-c> "+y
else
    vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
endif

:map <C-v> "+p
nmap <F2> :NERDTreeToggle<CR>.
let NERDTreeIgnore=['\.pyc$', '\~$']

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
Bundle 'fholgado/minibufexpl.vim.git'
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
Bundle 'bufexplorer.zip'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'jade.vim'
Bundle 'fsouza/go.vim'
Bundle 'rust-lang/rust.vim'

filetype indent on
filetype plugin indent on     " required!

" Set this toggle to make code paste more easily
set pastetoggle=<F7>

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

nmap <F8> :TagbarToggle<CR>

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" session
function GetProjectName()
    let edit_files = split(system("ps -o command= -p " . getpid()))
    if len(edit_files) >= 2
        let project_path = edit_files[1]
        if project_path[0] != '/'
            let project_path = getcwd() . project_path
        endif
    else
        let project_path = getcwd()
    endif

    return shellescape(substitute(project_path, '[/]', '', 'g'))
endfunction

function SaveSession()
    execute ':NERDTreeClose'
    execute ':MBECloseAll'
    let project_name = GetProjectName()
    execute 'mksession! ~/.vim/sessions/' . project_name
endfunction

function RestoreSession()
    let project_name = GetProjectName()
    let session_path = expand('~/.vim/sessions/' . project_name)
    if filereadable(session_path)
        execute 'so ' . session_path
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
    syntax on
endfunction

nmap ssa :call SaveSession()
smap SO :call RestoreSession()
autocmd VimLeave * call SaveSession()
autocmd VimEnter * call RestoreSession()
