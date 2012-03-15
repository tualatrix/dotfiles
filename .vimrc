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
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */etc/init.d/* set ft=sh

set tabstop=4
set shiftwidth=4
set expandtab

:map <F12> :!python -m pdb %<CR>
" :map <C-c> "+y
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
:map <C-v> "+p
nmap <F2> :NERDTreeToggle<CR>.

set list
set listchars=tab:▸\ ,eol:¬

fun SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  "   to fetch VAM, VAM-known-repositories and the listed plugins
  "   without having to install curl, unzip, git tool chain first
  " -> BUG [4] (git-less installation)
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  " Example drop git sources unless git is in PATH. Same plugins can
  " be installed form www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

  call vam#ActivateAddons(['github:tualatrix/snipmate-snippets',
                        \  'github:tualatrix/vim-snipmate',
                        \  'github:vim-ruby/vim-ruby',
                        \  'github:tpope/vim-rails',
                        \  'vim-coffee-script',
                        \  'nginx',
                        \  'ctrlp',
                        \  'ack',
                        \  'sparkup',
                        \  'rainbow_parentheses',
                        \  'vim-less',
                        \  'fugitive',
                        \  'github:bbommarito/vim-slim',
                        \   ], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " where 'pluginA' could be "git://" "github:YourName" or "snipmate-snippets" see vam#install#RewriteName()
  " also see section "5. Installing plugins" in VAM's documentation
  " which will tell you how to find the plugin names of a plugin
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]

" Set this toggle to make code paste more easily
set pastetoggle=<F7>

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn|\.swp$'

autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

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

" disable the sparkup
let g:sparkupNextMapping = '<c-s>'
