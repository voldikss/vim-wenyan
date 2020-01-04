" File: CFile
" Author: lymslive
" Description: job that output to a file
" Create: 2020-01-04
" Modify: 2020-01-04

let s:class = copy(lib#CJob#class())
let s:class.file = ''        " output to this file
let s:class.context = v:null " any custome data

" Func: #class 
function! lib#job#CFile#class() abort
    return class
endfunction

" Func: #new 
function! lib#job#CFile#new(cmd, file, done) abort
    " let l:obj = lib#CJob#new(a:cmd)
    let l:obj = copy(s:class)
    call l:obj.init(a:cmd)
    let l:obj.file = a:file
    if type(a:done) == v:t_func
        let l:obj.callback.done = a:done
    else
        throw 'need a callback when done'
    endif
    return l:obj
endfunction

" Method: options 
function! s:class.options() dict abort
    let l:options = {}
    let l:options.out_io = 'file'
    let l:options.out_name = self.file
    let l:options.exit_cb = self.exit_cb
    return l:options
endfunction

" Method: exit_cb 
function! s:class.exit_cb(job, status) dict abort
    if !empty(self.callback) && !empty(self.callback.done)
        call self.callback.done(self, a:status)
    endif
endfunction
