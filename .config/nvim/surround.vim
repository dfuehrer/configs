
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
