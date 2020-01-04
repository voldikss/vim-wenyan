" File: complete
" Author: lymslive
" Description: complete for command
" Create: 2020-01-04
" Modify: 2020-01-04

" Func: #target 
function! wenyan#complete#target(A, L, P) abort
    let l:targets = ['js', 'py', 'rb']
    return join(l:targets, "\n")
endfunction

" Func: #clean 
function! wenyan#complete#clean(A, L, P) abort
    let l:targets = ['js', 'py', 'rb', 'svg']
    return join(l:targets, "\n")
endfunction
