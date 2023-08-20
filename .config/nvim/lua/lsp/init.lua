print('in lsp/init.lua')
-- set options, kepmaps, and on_attach function
require ('lsp.set')
require ('lsp.keymap')
require ('lsp.attach')
local on_attach = require ('lsp.attach').on_attach

local lspconfig = require ('lspconfig')
-- setup python
lspconfig['pyright'].setup{
    on_attach = on_attach,
}
-- setup C/C++
lspconfig['clangd'].setup{
    on_attach = on_attach,
}
-- setup rust
lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
    cmd = {'rustup', 'run', 'stable', 'rust-analyzer'},
}
-- setup zig
lspconfig['zls'].setup{
    on_attach = on_attach,
}
