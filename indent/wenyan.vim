" Vim indent file
" Language: wenyan-lang

if exists("b:did_indent")
	finish
endif

let b:did_indent = 1

setlocal indentexpr=GetWenyanIndent(v:lnum)

if exists("*GetWenyanIndent")
	finish
endif

function! s:GetPrevNonCommentLineNum( lnum )
	let SKIP_LINES = '\v^\s*(批|疏|注)曰.*$'

	let lnum = a:lnum
	while lnum > 0
		let lnum = prevnonblank(lnum-1)
		if getline(lnum) !~? SKIP_LINES
			break
		endif
	endwhile

	return lnum
endfunction

function! GetWenyanIndent( line_num )
	if a:line_num == 0
		return 0
	endif

	let curr_line = getline( a:line_num )
	let prev_lnum = s:GetPrevNonCommentLineNum( a:line_num )
	let prev_line = getline( prev_lnum )
	let prev_indent = indent( prev_lnum )


  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" INCREASE INDENT
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " define|declare|assign
	if prev_line =~ '\v\<(吾有|今有|有|曰|名之曰)$'
		return prev_indent + shiftwidth()
	endif

  " function
	if prev_line =~ '\v是術曰。'
		return prev_indent + shiftwidth()
	endif

  " for|for_in
	if prev_line =~ '\v凡.*中之.*'
		return prev_indent + shiftwidth()
	endif

  " whiletrue
	if prev_line =~ '\v恆為是'
		return prev_indent + shiftwidth()
	endif

  " whilelen0|whilelen1
	if prev_line =~ '\v為是.*遍'
		return prev_indent + shiftwidth()
	endif


  " if|if_statement|else
	if prev_line =~ '\v若.*者|若非'
		return prev_indent + shiftwidth()
	endif


  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" DECREASE INDENT
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " else|endif|end
	if curr_line =~ '\v若非|也|云云'
		return prev_indent - shiftwidth()
	endif

  " function_end
	if curr_line =~ '^\s*是謂「.*」之術也。'
		return prev_indent - shiftwidth()
	endif

	return prev_indent
endfunction
