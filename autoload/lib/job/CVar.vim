" File: CVar
" Author: lymslive
" Description: job that output to viml variable
" Create: 2020-01-04
" Modify: 2020-01-04

let s:class = copy(lib#CJob#class())
let s:class.result = v:null  " output to this file
let s:class.context = v:null " any custome data

" Func: #class 
function! lib#job#CVar#class() abort
    return class
endfunction

" Func: #new 
function! lib#job#CVar#new(cmd, done) abort
    let l:obj = copy(s:class)
    call l:obj.init(a:cmd)
    let l:obj.result = []
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
    let l:options.out_io = 'pipe'
    let l:options.err_io = 'out'
    let l:options.callback = self.doing_cb
    let l:options.close_cb = self.close_cb
    let l:options.exit_cb = self.exit_cb
    return l:options
endfunction

" Method: doing_cb 
function! s:class.doing_cb(channel, text) dict abort
    call add(self.result, a:text)
endfunction

" Method: close_cb 
" see also: skywind3000/asyncrun.vim plugin
function! s:class.close_cb(channel) dict abort
    let l:tryread = 64
    let l:options = {'timeout':0}
    while ch_status(a:channel) == 'buffered'
        let l:text = ch_read(a:channel, l:options)
        if l:text == '' " important when child process is killed
            let l:tryread -= 1
            if l:tryread < 0 | break | endif
        else
            call self.doing_cb(a:channel, l:text)
        endif
    endwhile
    call self.status()
endfunction

" Method: exit_cb 
function! s:class.exit_cb(job, status) dict abort
    if !empty(self.callback) && !empty(self.callback.done)
        call self.callback.done(self, a:status)
    endif
endfunction

