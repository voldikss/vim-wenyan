" Vim filetype plugin
" Language: wenyan-lang

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal commentstring=批曰\ %s
setlocal foldmethod=indent

inoremap <buffer> '' 「」<Left>
inoremap <buffer> "" 「「」」<Left><Left>
inoremap <buffer> // 批曰。

let &cpo = s:cpo_save
unlet s:cpo_save
