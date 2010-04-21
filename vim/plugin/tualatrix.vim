function Count_words() range
	let lnum = a:firstline
	let n = 0
	while lnum <= a:lastline
		let n = n + len(split(getline(lnum)))
		let lnum = lnum + 1
	endwhile
	echo "found " . n . " words"
endfunction

function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfunction

function CommentBlock(comment, ...)
    "If 1 or more optional args, first optional arg is introducer...
    let introducer =  a:0 >= 1  ?  a:1  :  "//"

    "If 2 or more optional args, second optional arg is boxing character...
    let box_char   =  a:0 >= 2  ?  a:2  :  "*"

    "If 3 or more optional args, third optional arg is comment width...
    let width      =  a:0 >= 3  ?  a:3  :  strlen(a:comment) + 2

    " Build the comment box and put the comment inside it...
    return introducer . repeat(box_char,width) . "\<CR>"
    \    . introducer . " " . a:comment        . "\<CR>"
    \    . introducer . repeat(box_char,width) . "\<CR>"
endfunction

function AddStar() range
				"Step through each line in the range...
    for linenum in range(a:firstline, a:lastline)
        "Replace loose ampersands (as in DeAmperfy())...
        let curr_line   = getline(linenum)
        let replacement = ' * '.curr_line
        call setline(linenum, replacement)
    endfor

    "Report what was done...
    if a:lastline > a:firstline
        echo "Add Star Finished" (a:lastline - a:firstline + 1) "lines"
    endif
endfunction

function BreakToLines() range
				"Step through each line in the range...
    for linenum in range(a:firstline, a:lastline)
        "Replace loose ampersands (as in DeAmperfy())...
        let curr_line   = getline(linenum)
        let words_list = split(curr_line, ', ')
	call setline(linenum, words_list[0])
        call append(linenum, words_list[1:])
    endfor

    "Report what was done...
    if a:lastline > a:firstline
        echo "Add Star Finished" (a:lastline - a:firstline + 1) "lines"
    endif
endfunction

function DjangoBlock()
        let curr_line   = getline(".")
        let back_word = split(curr_line)[-1]
	let block = "{% block ".back_word." %}{% endblock %}"
	let replace = substitute(curr_line, back_word."$", '', "g")
	call setline(".", replace)
	return block
endfunction

function SetCursorBack()
	let [lnum, col] = searchpos('}{', 'nb')
	call cursor(lnum, col+1)
	return ''
endfunction

nmap <silent>  ;s  :call ToggleSyntax()<CR>
"C++/Java/PHP comment...
imap <silent>  ///  <C-R>=CommentBlock(input("Enter comment: "))<CR>

"Ada/Applescript/Eiffel comment...
imap <silent>  ---  <C-R>=CommentBlock(input("Enter comment: "),'--')<CR>

"Perl/Python/Shell comment...
imap <silent>  ###  <C-R>=CommentBlock(input("Enter comment: "),'#','#')<CR>
nmap ;st Vip:call AddStar()
nmap ;bl Vip:call BreakToLines()
imap <C-D><C-B> <C-R>=DjangoBlock()<CR> <C-R>=SetCursorBack()<CR>
