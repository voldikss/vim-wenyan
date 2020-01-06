" may copy this file to ~/.vim/autoload/wenyan
" and make custom changing to override the default setting

" if cloned wenyan-lang in some local foler
" eg. ~/downloads/github/wenyan-lang
let g:wenyan#config#local_repos = ''

let g:wenyan#config#snippet_site = 'https://wenyan-snippets.glitch.me'

" Func: #load 
function! wenyan#config#load() abort
    return 1
endfunction
