
" these are a bunch of functions and mappings to let me surround some text
" object with the specified symbol
nnoremap <silent> <leader>S[ :set opfunc=SurroundBraket<CR>g@
vnoremap <silent> <leader>S[ :<C-U>call SurroundBraket(visualmode(), 1)<CR>
function! SurroundBraket(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i[\<Esc>`>l"
    silent exe "normal! a]\<Esc>"

    let &selection = sel_save
endfunction

nnoremap <silent> <leader>S{ :set opfunc=SurroundBrace<CR>g@
vnoremap <silent> <leader>S{ :<C-U>call SurroundBrace(visualmode(), 1)<CR>
function! SurroundBrace(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i{\<Esc>`>l"
    silent exe "normal! a}\<Esc>"

    let &selection = sel_save
endfunction

nnoremap <silent> <leader>S( :set opfunc=SurroundParen<CR>g@
vnoremap <silent> <leader>S( :<C-U>call SurroundParen(visualmode(), 1)<CR>
function! SurroundParen(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i(\<Esc>`>l"
    silent exe "normal! a)\<Esc>"

    let &selection = sel_save
endfunction

nnoremap <silent> <leader>S" :set opfunc=SurroundQuote<CR>g@
vnoremap <silent> <leader>S" :<C-U>call SurroundQuote(visualmode(), 1)<CR>
function! SurroundQuote(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i\"\<Esc>`>l"
    silent exe "normal! a\"\<Esc>"

    let &selection = sel_save
endfunction

nnoremap <silent> <leader>S' :set opfunc=SurroundSingleQuote<CR>g@
vnoremap <silent> <leader>S' :<C-U>call SurroundSingleQuote(visualmode(), 1)<CR>
function! SurroundSingleQuote(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i'\<Esc>`>l"
    silent exe "normal! a'\<Esc>"

    let &selection = sel_save
endfunction

nnoremap <silent> <leader>S<Space> :set opfunc=SurroundSpace<CR>g@
vnoremap <silent> <leader>S<Space> :<C-U>call SurroundSpace(visualmode(), 1)<CR>
function! SurroundSpace(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    silent exe "normal! `<i \<Esc>`>l"
    silent exe "normal! a \<Esc>"

    let &selection = sel_save
endfunction

nnoremap <leader>S :set opfunc=SurroundAny<CR>g@
vnoremap <leader>S :<C-U>call SurroundAny(visualmode(), 1)<CR>
function! SurroundAny(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\<Esc>"
    elseif a:type == 'line'
        silent exe "normal! '[V']\<Esc>"
    else
        silent exe "normal! `[v`]\<Esc>"
    endif

    let s:doubles = '([{<>}])'
    let l:dblLen = strchars(s:doubles)

    let l:printLeft = nr2char(getchar())
    let l:pos = stridx(s:doubles, l:printLeft)
    if l:pos >= l:dblLen / 2
        let l:printRight = l:printLeft
        let l:printLeft = nr2char(strgetchar(s:doubles, l:dblLen - l:pos - 1))
    elseif l:pos >= 0
        let l:printRight = nr2char(strgetchar(s:doubles, l:dblLen - l:pos - 1))
    else
        let l:printRight = l:printLeft
    endif
    "" turn off indent
    "silent exe "normal! `<i" . l:printLeft . "\<Esc>`>l"
    "silent exe "normal! a" . l:printRight . "\<Esc>"
    "" turn on indent
    echomsg '"' . l:printRight . '"'
    let g:outputvar = '"' . l:printRight . '"'

    let l:zeroSave = @0
    let @0 = l:printLeft
    exe "normal! `<\"0P`>"
    let @0 = l:printRight
    exe "normal! \"0p"
    let @0 = l:zeroSave

    echomsg l:printLeft . l:printRight

    let &selection = sel_save
endfunction

nmap gS :call SurroundWrapper()<CR>
" this function is just to make it so i can hopefully give the char before the
" text object like i had it so its useless in visual mode
""vmap gS :<C-U>call SurroundWrapper()
"vnoremap <silent> gS :<C-U>call SurroundAny(visualmode(), 1)<CR>
function! SurroundWrapper()
    " first get the char to surround with
    let l:surroundChar = nr2char(getchar())
    set opfunc=SurroundAny
    let l:char = ''
    let l:motion = ''
    let didthign = 0
    while l:char != "\<Esc>" && didthign == 0
        let l:char = nr2char(getchar())
        let l:motion = l:motion . l:char
        "exe "normal g@" . l:motion . l:surroundChar . ":let didthign=1\<CR>"
        " just having it go into visual mode to test if the motion worked
        exe "normal \<Esc>v" . l:motion  . "v\<Esc>:let didthign = 1\<CR>"
    endwhile
    exe "normal \<Esc>g@" . l:motion . l:surroundChar
    unlet didthign
endfunction
