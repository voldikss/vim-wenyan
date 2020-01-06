" File: complete
" Author: lymslive
" Description: complete for command
" Create: 2020-01-04
" Modify: 2020-01-05

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

" Func: #example 
function! wenyan#complete#example(A, L, P) abort
    let l:refer = g:wenyan#refer#space
    let l:names = get(l:refer.dExample, 'names', [])
    return join(l:names, "\n")
endfunction

" Func: #snippet 
function! wenyan#complete#snippet(A, L, P) abort
    let l:refer = g:wenyan#refer#space
    if !has_key(l:refer.dSnippet, 'mapTitle')
        return ''
    endif
    let l:title = keys(l:refer.dSnippet.mapTitle)
    call sort(l:title)
    return join(l:title, "\n")
endfunction
