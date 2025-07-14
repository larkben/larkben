call plug#begin('~/.vim/plugged')

" Add your plugins here, for example:
" Plug 'tpope/vim-sensible'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

Plug 'nightsense/carbonized'

" File explorer
Plug 'tpope/vim-vinegar'

" lsp language support
Plug 'rust-lang/rust.vim'
Plug 'alephium/ralph-lsp'
Plug 'tdroxler/ralph.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" LSP support for code completion, diagnostics, etc.
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Fuzzy finder for files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme carbonized-dark

" Open file explorer with minus key (vim-vinegar default)
" Press - to open current directory, I to toggle hidden files

" Rustu Analyzer
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

" Ralph-LSP
if executable('java')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'ralph-lsp',
    \ 'cmd': {server_info->['java', '-jar', expand('~/Downloads/ralph-lsp.jar'), '--stdio']},
    \ 'allowlist': ['ralph'],
    \ })
endif

" Typescript LSP
if executable('typescript-language-server')
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
    \ 'allowlist': ['typescript', 'javascript', 'typescriptreact', 'javascriptreact'],
    \ })
endif

autocmd BufNewFile,BufRead *.ral set filetype=ralph

autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

" Enable LSP logging for debugging
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" LSP settings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup ENDp
