" File: CJob
" Author: lymslive
" Description: 
" Create: 2020-01-04
" Modify: 2020-01-04

let s:class = {}
let s:class.command = ''
let s:class.output = ''
let s:class.jobid = 0
let s:class.callback = v:null

" Func: #class
function! lib#CJob#class() abort
    return s:class
endfunction

" Func: #new 
function! lib#CJob#new(cmd) abort
    let l:obj = copy(s:class)
    return l:obj.init(a:cmd)
endfunction

" Method: init 
function! s:class.init(cmd) dict abort
    let self.command = a:cmd
    let self.callback = {}
    return self
endfunction

" Method: start
function! s:class.start() dict abort
    let l:options = self.options()
    let self.jobid = job_start(self.command, l:options)
    return self
endfunction

" Method: stop 
function! s:class.stop() dict abort
    call job_stop(self.jobid)
    return self
endfunction

" Method: status 
function! s:class.status() dict abort
    return job_status(self.jobid)
endfunction

