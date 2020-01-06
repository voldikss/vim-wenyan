" File: buffer
" Author: lymslive
" Description: buffer functionaly for wenyan
" Create: 2020-01-04
" Modify: 2020-01-04

" Func: #compile 
function! wenyan#buffer#compile(...) abort
    let l:target = 'js'
    if a:0 > 0 && !empty(a:1)
        let l:target = a:1
    endif
    let l:wyfile = expand('%:p')
    let l:cpfile = fnamemodify(l:wyfile, ':r') . '.' . l:target
    let l:runner = wenyan#CRunner#new(l:wyfile)
                \.lang(l:target)
                \.compile(l:cpfile)
    let l:cmd = l:runner.string()
    let l:job = lib#job#CFile#new(l:cmd, l:cpfile, function('s:doneCompile'))
    let l:job.context = l:wyfile
    call l:job.start()
    return 0
endfunction

" Func: #run 
function! wenyan#buffer#run(...) abort
    let l:target = 'js'
    if a:0 > 0 && !empty(a:1)
        let l:target = a:1
    endif
    let l:wyfile = expand('%:p')
    let l:cpfile = fnamemodify(l:wyfile, ':r') . '.' . l:target
    let l:runner = wenyan#CRunner#new(l:wyfile)
                \.lang(l:target)
    let l:cmd = l:runner.string()
    let l:job = lib#job#CVar#new(l:cmd, function('s:doneRun'))
    let l:job.context = l:wyfile
    call l:job.start()
endfunction

" Func: #render 
function! wenyan#buffer#render(...) abort
    let l:title = ''
    if a:0 > 0 && !empty(a:1)
        let l:title = a:1
    endif
    let l:wyfile = expand('%:p')
    let l:svgfile = fnamemodify(l:wyfile, ':r') . '.svg'
    let l:runner = wenyan#CRunner#new(l:wyfile)
                \.render(l:title)
    let l:cmd = l:runner.string()
    let l:job = lib#job#CVar#new(l:cmd, function('s:doneRender'))
    let l:job.context = l:wyfile
    call l:job.start()
    return 0
endfunction

" Func: #clean 
" delete the middle js/py/rb/svg
function! wenyan#buffer#clean(...) abort
    if a:0 == 0
        let l:clean = split(wenyan#complete#clean(1,1,1), "\n")
    else
        let l:clean = a:000
    endif
    let l:filename = expand('%:p:r')
    for l:target in l:clean
        let l:filepath = l:filename . '.' . l:target
        if filereadable(l:filepath)
            call delete(l:filepath)
            echo 'delete file: ' . l:filepath
        endif
    endfor
endfunction

" Func: s:doneCompile 
function! s:doneCompile(job, status) abort
    let l:job = a:job
    let l:wyfile = l:job.context
    let l:cpfile = l:job.file

    " close all other window, vertically open these two files
    wincmd o
    if expand('%:p') !=# l:wyfile
        execute 'edit ' l:wyfile
    endif
    execute 'rightbelow vsplit ' l:cpfile
endfunction

" Func: s:doneRun 
function! s:doneRun(job, status) abort
    let l:result = a:job.result
    echo join(l:result, "\n")
endfunction

" Func: s:doneRender 
" wenyan --render just output the result filename.svg
function! s:doneRender(job, status) abort
    let l:result = a:job.result
    echo join(l:result, "\n")
endfunction
