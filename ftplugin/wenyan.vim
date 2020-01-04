" Vim filetype plugin
" Language: wenyan-lang

if exists("b:did_ftplugin") && !exists('g:DEBUG')
  finish
endif
let b:did_ftplugin = 1
let s:cpo_save = &cpo
set cpo&vim
" --------------------------------------------------------------------------------

setlocal commentstring=批曰\ %s
setlocal foldmethod=indent

inoremap <buffer> ' 「」<Left>
" inoremap <buffer> " 「「」」<Left><Left>
inoremap <buffer> " 『』<Left>
inoremap <buffer> // 批曰『』<Left>
inoremap <buffer> /, 疏曰『』<Left>
inoremap <buffer> /. 注曰『』<Left>

command! -buffer -nargs=? -complete=custom,wenyan#complete#target
            \ Compile call wenyan#buffer#compile(<f-args>)
command! -buffer -nargs=? -complete=custom,wenyan#complete#target
            \ Run call wenyan#buffer#run(<f-args>)
command! -buffer -nargs=? -complete=custom,wenyan#complete#target
            \ Render call wenyan#buffer#render(<f-args>)
command! -buffer -nargs=? -complete=custom,wenyan#complete#clean
            \ Clean call wenyan#buffer#clean(<f-args>)

nnoremap <buffer> <F9> <Esc>:Compile<CR>
nnoremap <buffer> <F5> <Esc>:Run<CR>
nnoremap <buffer> <F6> <Esc>:Render<CR>
" required comfirm <CR> to clean
nnoremap <buffer> <S-F9> <Esc>:Clean

" --------------------------------------------------------------------------------
let &cpo = s:cpo_save
unlet s:cpo_save
