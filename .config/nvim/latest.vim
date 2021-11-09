
" always use a menu, show the preview box, dont select yet (when i tab or ^n
" it will go to the first option and start filling it in)
set completeopt=menuone,preview,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" set a column on the side for putting error stuff in and stuff
" TODO maybe only set if that file will have some use like i have a lsp or git
set signcolumn=yes

" i dont know if these are any good but i copied them from the online docs
" (the docs in nvim here seem to have been updated to not have this)
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <M-k> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

augroup help
    autocmd!
    autocmd FileType help nunmap <c-]>
augroup END

lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').pyright.setup{ on_attach=require'completion'.on_attach }
