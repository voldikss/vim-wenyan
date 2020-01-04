" File: CRunner
" Author: lymslive
" Description: build wenyan command line fit for vim execute/job
" Create: 2020-01-04
" Modify: 2020-01-04

let s:class = {}
let s:class.files_ = v:null
let s:class.lang_ = 'js'
let s:class.compile_ = v:false
let s:class.output_ = ''
let s:class.render_ = v:false
let s:class.title_ = ''

" Func: #class 
function! wenyan#CRunner#class() abort
    return s:class
endfunction

" Func: #new 
function! wenyan#CRunner#new(...) abort
    let l:obj = copy(s:class)
    if a:0 > 0
        let l:obj.files_ = a:000
    else
        let l:obj.files_ = []
    endif
    return l:obj
endfunction

" Method: file 
function! s:class.file(...) dict abort
    call extend(self.files_, a:000)
    return self
endfunction

" Method: compile 
function! s:class.compile(outfile) dict abort
    let self.compile_ = v:true
    let self.output_ = a:outfile
    return self
endfunction

" Method: lang 
function! s:class.lang(target) dict abort
    let self.lang_ = a:target
    return self
endfunction

" Method: render 
function! s:class.render(...) dict abort
    let self.render_ = v:true
    if a:0 > 0 && !empty(a:1)
        let self.title_ = a:1
    endif
    return self
endfunction

" Method: string 
" return a command as string
function! s:class.string() dict abort
    let l:cmd = 'wenyan'
    if !empty(self.lang_)
        let l:cmd .= ' --lang ' . self.lang_
    endif
    if !empty(self.compile_)
        let l:cmd .= ' --compile '
    endif
    if !empty(self.output_)
        let l:cmd .= ' --output ' . s:dquote(self.output_)
    endif
    if !empty(self.render_)
        let l:cmd .= ' --render '
    endif
    if !empty(self.title_)
        let l:cmd .= ' --title ' . s:dquote(self.title_)
    endif
    for l:file in self.files_
        let l:cmd .= ' ' . s:dquote(l:file)
    endfor
    return l:cmd
endfunction

" Func: s:dquote 
function! s:dquote(string) abort
    return printf('"%s"', escape(a:string, '"'))
endfunction
