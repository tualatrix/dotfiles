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

nmap <silent>  ;s  :call ToggleSyntax()<CR>
