" Vim filetype detect file
" Language: wenyan-lang

autocmd BufNewFile,BufRead *.wy     set filetype=wenyan
autocmd BufNewFile,BufRead *.wenyan set filetype=wenyan
autocmd BufNewFile,BufRead *.文言 set filetype=wenyan
