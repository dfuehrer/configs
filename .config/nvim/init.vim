" use space as the leader cuase its easier to hit than \ and it doesnt do much
let mapleader=' '

if exists('g:vscode')
    " VSCode extension
    map <M-J> :call VSCodeCall('editor.action.moveLinesUpAction')
    map <M-K> :call VSCodeCall('editor.action.moveLinesDownAction')
    set incsearch hlsearch
    set ignorecase smartcase
else
    " ordinary neovim
    
    " indent by filetype, use syntax highlighting
    filetype indent plugin on
    syntax enable
    " numbers are necessary, relative is helpful for moves like 10j
    set number relativenumber
    " incrementally search, highlight; case insensitive, but smart by being case
    " sensitive if use uppercase
    set incsearch hlsearch
    set ignorecase smartcase
    " use 4 spaces instead of tabs, shift by 4 with >>
    set expandtab
    set shiftwidth=4 tabstop=4 softtabstop=4
    " TODO add in arduino libraries or something
    " the ** should do expanding things to let me search subdirectories
    set path=.,**
    " create splits below and right not above and left
    set splitright splitbelow
    " let me use mouse but not in insert mode
    " can be annoying but wont let touchpad mess me up
    set mouse=nvc
    " when doing big combined moves dont draw everything for speed
    set lazyredraw
    " if a line is super long show as much as you can rather than nothing
    set display=lastline
    " dont let me go in the top/bot 3 lines (if i do scroll)
    set scrolloff=3
    " set window title based on file
    set title
    " use unix line endings
    set fileformat=unix
    " cd to the dir of the file rather than all in same dir (can be weird)
    set autochdir
    " get rid of the tabline
    set guioptions-=e
    " ive gotten used to lines wrapping so i can see the whole thing
    set wrap linebreak
    " break and have the broken line at the same indent
    set breakindent
    " i want this to work but i guess this isnt a thing in nvim
    "set clipboard=autoselect
    " in command mode tab complete by completing as much as possible then pull up
    " a thing
    set wildmode=longest,full
    " dont unload buffers that arent seen
    "set hidden
    " dont ring at me
    set noerrorbells
    set novisualbell
    " TODO make this detect when this wont work like when in dvtm
    "   until then ill just get rid of it since it isnt doing a ton for me
    "   nevermind im adding it again
    if exists('+termguicolors')
        " 24bit color in tui
        set termguicolors
    endif

    " this is a section of things im trying but might delete
    " when jumping dont change column to the start of the line
    set nostartofline
    " highlight the line im on (its subtle in this theme )
    set cursorline
    " set the clipboard to put everything in the * register
    set clipboard=unnamed
    " these need to go together, otherwise its just too long
    set showmatch matchtime=1
    " if theres a .exrc or .vimrc in the dir loaded then source it
    set exrc
    " show whitespace (probably will remove)
    set list
    " options for menus, show menu if still only 1 option and dont insert
    " automag
    set completeopt=menuone,longest,preview

    " set fold with syntax, if its python i guess try to set it with indent
    set foldmethod=syntax
    "autocmd BufRead *.py set foldmethod=indent
    autocmd FileType python set foldmethod=indent
    " then unset foldenable so that the folds arent shown but arent removed
    " this is still annoying but whatever
    set nofoldenable

    map <leader>d :set digraph!
    " alt+r does mode to reset the screen if it gets screwed up
    map <M-R> :mode<CR>
    " tabs move tabs
    map <C-Tab> :tabnext<CR>
    map <C-S-Tab> :tabprev<CR>
    " map <Tab> gt
    " map <S-Tab> gT

    "imap <C-BS> <Esc>vbj
    " make crtl+backspace do what everything else does
    "imap <C-BS> <C-\><C-o>db
    "imap  <C-\><C-o>db
    "imap <C-S-BS> <C-\><C-o>dB
    "imap <C-S-BS> <C-\><C-o>dB
    " scroll in insert with crtl+e/y
    imap <C-e> <C-x><C-e>
    imap <C-y> <C-x><C-y>
    " reset undo stuffs in insert every CR
    inoremap <CR> <C-]><C-g>u<CR>
    " i know there must be a better way to do this but this will unmap ^e and ^y
    " when you go in a autocomplete thingy and then remap it so that you can
    " scroll easier in insert mode
    " this is because they way to cancel out of autocomplete is ^e or ^y
    augroup ctrle
        autocmd!
        " remove this command after the first time so that we dont get an error
        " cause the mapping doesnt exist anymore
        autocmd CompleteChanged * ++once silent! iunmap <C-E>|:silent! iunmap <C-Y>
        autocmd CompleteDone * imap <C-e> <C-x><C-e>|:imap <C-y> <C-x><C-y>
        " reset the unmap command when we leave the completion thingy
        autocmd CompleteDone * autocmd CompleteChanged * ++once silent! iunmap <C-E>|:silent! iunmap <C-Y>
    augroup END

    " TODO add these to the vscode version
    " move lines up and down
    vnoremap <M-J> :mo '>+1<CR>gv=gv
    vnoremap <M-K> :mo '<-2<CR>gv=gv
    nnoremap <M-J> m`:mo+1<CR>==``
    nnoremap <M-K> m`:mo-2<CR>==``
    " put me in norm command from visual mode cause norm is nice
    vmap <C-n> :norm 
    " TODO see if this stuff works in vscode to put in the area for both
    " TODO on that note organize this better so my normal bashrc isnt taken up
    " by this and i can just have the normal thing and dont have to worry
    " make ^p an operator for pasting
    map <silent> <C-p> :set opfunc=CPaste<CR>g@
    " paste in the object, so ^p can be an operator for pasting things
    function! CPaste(type, ...)
        let sel_save = &selection
        let &selection = "inclusive"

        " cant call this in visual cause thats stupid
        if a:type == 'line'
            silent exe "normal! '[V']p"
        else
            silent exe "normal! `[v`]p"
        endif

        let &selection = sel_save
    endfunction


    " make a operator for ^s that searches the object or selection
    nmap <silent> <C-s> :set opfunc=FindSel<CR>g@
    vmap <silent> <C-s> :<C-U>call FindSel(visualmode(), 1)<CR>
    " this function searches the object by yanking it and setting the / register
    " to that yank and calling /<CR> to start the search
    function! FindSel(type, ...)
        let sel_save = &selection
        let &selection = "inclusive"

        if a:0  " Invoked from Visual mode, use gv command.
            silent exe "normal! gvy"
        elseif a:type == 'line'
            silent exe "normal! '[V']y"
        else
            silent exe "normal! `[v`]y"
        endif
        " i doubt exe does anything for me here but
        exe "let @/ = @\""
        exe "normal! /<CR>"

        let &selection = sel_save
    endfunction

    " make a operator to count words
    nmap <leader>c :set opfunc=CountWords<CR>g@
    vmap <leader>c :<C-U>call CountWords(visualmode(), 1)<CR>
    function! CountWords(type, ...)
        let sel_save = &selection
        let &selection = "inclusive"
        let regsave = @"

        if a:0  " Invoked from Visual mode, use gv command.
            silent exe "normal! gvy"
        elseif a:type == 'line'
            silent exe "normal! '[V']y"
        else
            silent exe "normal! `[v`]y"
        endif

        echomsg strlen(substitute(substitute(@", '[^[:space:]]\+', '.', 'g'), '[[:space:]]\+', '', 'g'))

        let @" = regsave
        let &selection = sel_save
    endfunction

    " i want surround but i dont want the nice plugin cuase it sounds ez
    nmap <leader>S[ :set opfunc=Surround<CR>g@

    " ill figure this out later
    function! Surround(type, ...)
        let sel_save = &selection
        let &selection = "inclusive"

        " if a:0  " Invoked from Visual mode, use gv command.
        "     silent exe "normal! gvy"
        " elseif a:type == 'line'
        "     silent exe "normal! '[V']y"
        " else
        "     silent exe "normal! `[v`]y"
        " endif

        let &selection = sel_save
    endfunction

    " toggle search highlights
    map <leader>H :setlocal hlsearch!<CR>
    " set the search to nothing so that it goes away but i dont have to turn
    " highlights back on for next time
    map <leader>h :let @/ = ""<CR>
    "map <leader>o :setlocal spell! spelllang=en_us<CR>

    " this is a kinda hacky fix since nvim doesnt have great integration with
    " the system clipboard, when release the left mouse button copy the
    " selection to the (primary) clipboard
    vmap <LeftRelease> "*ygv

    "" set abbreviations for sourcing vimrc, detecting files, opening the vimrc,
    "" chmod ing this file to be executable
    "cabbrev src source $MYVIMRC
    cabbrev fd filetype detect
    "cabbrev taberc tabe $MYVIMRC
    "cabbrev chmex !chmod u+x %

    " let me save the temp files with just the highlighted line easily with ZZ for
    " dvtm copy mode
    augroup dvtm
        autocmd!
        autocmd BufRead dvtm-editor.* vnoremap ZZ :wq!<CR><CR>
    augroup END

    " this should source my vimrc when i save my vimrc
    " then i reenable lightline since it gets confused here
    augroup vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC|call lightline#enable()
    augroup END

    " arduino indenting is pretty broke so
    augroup arduino
        autocmd!
        autocmd BufRead *.ino set cindent|set path+=~/Arduino/libraries/**
    augroup END

    " this lets me use tab for the menu for tab complete
    augroup tabcomplete
        autocmd!
        autocmd CompleteChanged * silent! inoremap <Tab> <C-n>|silent! inoremap <S-Tab> <C-p>
        autocmd CompleteDone * silent! iunmap <Tab>|silent! iunmap <S-Tab>
    augroup END

    " dont want to save any of my data i was using for saving passwords in
    " plaintext swapfiles or backups
    augroup pass
        autocmd!
        autocmd BufEnter **/pass.*/* set noundofile noswapfile nobackup
    augroup END

    " do plugins
    " TODO consider git gutter if im not gonna ever enable coc
    " i have stuff for editing images casue im dumb
    " commenting, using git (maybe ill try it someday)
    " vscode dark theme, code completion (but commented out)
    " css-color (should find a better one) to show colors in real time
    " lightline is a nice bar
    " multiple-cursors i miss from vscode (maybe ill try it someday)
    " minimap i dont know how to make work (got a new one but it req nvim 0.5)
    call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-afterimage'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tomasiser/vim-code-dark'
    "Plug 'ap/vim-css-color'
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'itchyny/lightline.vim'
    Plug 'terryma/vim-multiple-cursors'
    "Plug 'severin-lemaignan/vim-minimap'
    "Plug 'ThePrimeagen/vim-be-good'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    if has('nvim-0.5')
        Plug 'nvim-lua/completion-nvim'
        Plug 'neovim/nvim-lspconfig'
        Plug 'wfxr/minimap.vim'
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-telescope/telescope-fzy-native.nvim'
    endif

    call plug#end()

    " use the vscode dark scheme
    colorscheme codedark
    set background=dark

    " show the color in the background of the symbols surronding the thing not
    " in a box on the side or full background
    "let g:Hexokinase_highlighters = ['background']
    let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
    let g:Hexokinase_ftOptInPatterns = {
    \     'css': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
    \     'html': 'full_hex,rgb,rgba,hsl,hsla,colour_names'
    \ }

    " i want to use c-/ but that isnt working here without the literal
    " let it comment using ctrl+/ with vim-commentary
    nmap <C-/> gcc
    nmap  gcc
    vmap <C-c> gc
    vmap <C-/> gc
    vmap  gc
    nmap <leader>ut :UndotreeToggle<CR>
    " someone mapped this but i want it for
    silent! nunmap <leader>o
    " let me toggle spellchecking (it is pretty cool cuase it only works in
    " comments and strings and stuff in code)
    map <leader>o :setlocal spell! spelllang=en_us<CR>
    " leader+s chooses the first spell suggestion
    map <leader>s z=1<CR><CR>


    " map some things for groff files like going into equations
    augroup groff
        autocmd!
        autocmd BufRead *.ms silent! nunmap <leader>e|map <leader>e o.EQ<CR>.EN<C-o>O
        autocmd BufRead *.ms map <leader>gp :!zathura %.pdf &<CR><CR>
        " i wanted to make it easier for it to update as i work by just having
        " it save when i exit insert mode but it doesnt work like that and its
        " kinda not a great idea in a lot of circumstances anyways
        "autocmd InsertLeave *.ms silent! w
        autocmd BufWritePost *.ms silent! !eqnlabel.sh % | pdfroff - -et -ms > %.pdf &
    augroup END




    if has('nvim-0.5')
        source ~/.config/nvim/latest.vim
    endif



endif



" show the command im doing in the bar
set showcmd
" use undo and swap files and put them in the cache directory
set undofile undodir=~/.cache/nvim/undo//
set swapfile directory=~/.cache/nvim/swap//


" ctrl+backspace deletes a word
imap <C-BS> <C-w>
imap  <C-w>
" move between splits without ctrl+w
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" change size of splits with arrows
map <M-S-Left> <C-W><
map <M-S-Down> <C-W>-
map <M-S-Up> <C-W>+
map <M-S-Right> <C-W>>
" go backwards tabs with GT casue its easier
nnoremap GG G
map GT gT
" Gt uses relative numbers like gT cause gt is absolute
map Gt @='gt'<CR>

" do Y like C and D to the end of the line
map Y y$
" write but dont quit
map ZW :w<CR>

" create the il object to select in a line (no whitespace or newline)
" al is just to use, selects whole line like V and lets me paste in a line for
" example with ^pal rather than Vp (not very helpful)
omap <silent> il :<C-u>normal! ^v$h<CR>
omap <silent> al :<C-u>normal! V<CR>
vmap il ^o$h

" move characters left and right with cut paste
" TODO it has issues at the edges
"nnoremap <M-H> xhP
nnoremap <M-H> hxph
nnoremap <M-L> xp


" chmod ing this file to be executable
cabbrev src source $MYVIMRC
"cabbrev fd filetype detect
cabbrev taberc tabe $MYVIMRC
cabbrev chmex !chmod u+x %
cabbrev usecoc source ~/.config/nvim/coc.vim

