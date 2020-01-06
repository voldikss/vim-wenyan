" File: refer
" Author: lymslive
" Description: refer to external wenyan code resource
" Create: 2020-01-05
" Modify: 2020-01-05

let g:wenyan#refer#space = s:
let s:dExample = {}
let s:dSnippet = {}
let s:SNIPPET_BUFFER_NAME = '__snippet__.wy'

" Func: #example 
function! wenyan#refer#example(...) abort
    if a:0 > 0 && !empty(a:1)
        return s:example_load(a:1)
    else
        return s:example_list()
    endif
endfunction

" Func: #snippet 
function! wenyan#refer#snippet(...) abort
    if !executable('curl')
        echomsg 'curl command not available, please reinstall'
        return
    endif
    if a:0 > 0 && !empty(a:1)
        return s:snippet_load(a:1)
    else
        return s:snippet_list()
    endif
endfunction

" Func: s:example_list 
function! s:example_list() abort
    if !empty(s:dExample)
        return s:example_list_menu()
    endif

    call wenyan#config#load()

    if !exists('g:wenyan#config#local_repos') 
                \ || empty(g:wenyan#config#local_repos)
                \ || !isdirectory(g:wenyan#config#local_repos)
        let l:reply = input("input the local repos path for wenyan-lang:\n", '', 'dir')
        if empty(l:reply)
            return
        endif
        let l:reply = expand(l:reply)
        let l:reply = substitute(l:reply, '[/\\]$', '', '')
        if !isdirectory(l:reply)
            echomsg 'not invalid directory'
            return
        endif
        echo ''
        let g:wenyan#config#local_repos = l:reply
    endif

    call s:read_example_info()
    return s:example_list_menu()
endfunction

" Func: s:read_example_info 
function! s:read_example_info() abort
    let l:info_js = g:wenyan#config#local_repos . '/tools/examples_info.js'
    if !filereadable(l:info_js)
        return
    endif
    let l:lines = readfile(l:info_js)
    if empty(l:lines)
        return
    endif
    let l:linestr = join(l:lines, '')
    let l:jsstr = matchstr(l:linestr, '{.*}')
    if empty(l:jsstr)
        return
    endif
    let l:obj = js_decode(l:jsstr)
    let l:examplesAlias = get(l:obj, 'examplesAlias', {})
    if empty(l:examplesAlias)
        return
    endif

    let s:dExample.alias = l:examplesAlias
    let s:dExample.names = sort(keys(l:examplesAlias))
    return
endfunction

" Func: s:example_list_menu 
function! s:example_list_menu() abort
    let l:output = []
    let l:idx = 0
    for l:key in s:dExample.names
        let l:idx += 1
        let l:val = s:dExample.alias[l:key]
        let l:line = printf("%d:\t%s\t%s", l:idx, l:key, l:val)
        call add(l:output, l:line)
    endfor

    echo join(l:output, "\n")
    let l:reply = input("select one example number/name: ", '', 'custom,wenyan#complete#example')
    if l:reply == '0' || empty(l:reply)
        return
    endif

    return s:example_load(l:reply)
endfunction

" Func: s:example_load 
function! s:example_load(arg) abort
    let l:arg = a:arg
    if empty(l:arg)
        return
    endif

    let l:name = ''
    let l:idx = 0 + l:arg
    if l:idx > 0
        let l:name = get(s:dExample.names, l:idx-1, '')
    else
        if has_key(s:dExample.alias, l:arg)
            let l:name = l:arg
        endif
    endif

    if empty(l:name)
        echomsg 'no such example: ' . a:arg
        return
    endif

    let l:filepath = printf('%s/examples/%s.wy', g:wenyan#config#local_repos, l:name)
    if !filereadable(l:filepath)
        echomsg 'cannot read example: ' . l:filepath
        return
    endif

    execute 'edit ' . l:filepath
endfunction

" Func: s:snippet_list 
function! s:snippet_list() abort
    if !empty(s:dSnippet)
        return s:snippet_list_menu()
    endif

    call wenyan#config#load()
    if empty(g:wenyan#config#snippet_site)
        return
    endif
    let l:cmd = 'curl -s ' . g:wenyan#config#snippet_site . '/all'
    let l:job = lib#job#CVar#new(l:cmd, function('s:doneSnippetList'))
    call l:job.start()
    echomsg l:cmd
    echomsg 'please wait for a short or long time ...'
endfunction

" Func: s:doneSnippetList 
function! s:doneSnippetList(job, status) abort
    if empty(a:job.result)
        echomsg 'no result, seams fail to fetch snippet list'
        return
    endif
    let l:text = join(a:job.result, '')
    " let s:dSnippet.rawtext = l:text
    let l:json = json_decode(l:text)
    if empty(l:json) || type(l:json) != v:t_list
        echomsg 'invalid result, seams fail to fetch snippet list'
        return
    endif

    let s:dSnippet.list = l:json
    let s:dSnippet.mapTitle = {}
    let s:dSnippet.mapId = {}
    let l:length = len(l:json)
    for l:idx in range(l:length)
        let l:snippet = l:json[l:idx]
        let l:id = get(l:snippet, 'id', 0)
        let l:title = get(l:snippet, 'title', '')
        if !empty(l:id)
            let s:dSnippet.mapId[l:id] = l:idx
        endif
        if !empty(l:title)
            let s:dSnippet.mapTitle[l:title] = l:idx
        endif
    endfor

    return s:snippet_list_menu()
endfunction

" Func: s:snippet_list_menu 
function! s:snippet_list_menu() abort
    let l:output = []
    let l:idx = 0
    for l:id in sort(keys(s:dSnippet.mapId), 'N')
        let l:idx = s:dSnippet.mapId[l:id]
        let l:snippet = s:dSnippet.list[l:idx]
        let l:title = get(l:snippet, 'title', '')
        let l:author = get(l:snippet, 'author', 'Anonymous')
        let l:line = printf("%d:\t%s\t@%s", l:id, l:title, l:author)
        call add(l:output, l:line)
    endfor

    echo join(l:output, "\n")
    let l:reply = input("select one snippet id/title: ", '', 'custom,wenyan#complete#snippet')
    if l:reply == '0' || empty(l:reply)
        return
    endif

    return s:snippet_load(l:reply)
endfunction

" Func: s:snippet_load 
function! s:snippet_load(arg) abort
    let l:arg = a:arg
    if empty(l:arg)
        return
    endif

    let l:idx = -1
    let l:id = 0 + l:arg
    if l:id > 0
        let l:idx = get(s:dSnippet.mapId, l:id, -1)
    else
        let l:idx = get(s:dSnippet.mapTitle, l:arg, -1)
    endif
    if l:idx < 0
        echoms 'no such snippet id/title'
        return
    endif

    let l:snippet = s:dSnippet.list[l:idx]
    let l:code = get(l:snippet, 'code', '')

    return s:view_snippet(split(l:code, "\n"))
endfunction

" Func: s:view_snippet 
function! s:view_snippet(code) abort
    if empty(a:code)
        return
    endif
    let l:bufnr = bufnr(s:SNIPPET_BUFFER_NAME)
    if l:bufnr == -1
        execute 'edit ' . s:SNIPPET_BUFFER_NAME
        setlocal buftype=nofile
    else
        execute 'buffer ' . l:bufnr
        1,$ delete
    endif
    call setline(1, a:code)
endfunction
