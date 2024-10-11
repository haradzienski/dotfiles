" Re-map <leader> to <Space>
nnoremap <Space> <Nop>
let mapleader = " "

" Display hybrid line numbers (relative and absolute)
set number relativenumber

" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " code competion
call plug#end()

" plug#end() enables syntax highlight, but without this setting it lags and
" times out on big files
set re=0
" vim-plug end

" netrw (the default file browser)
" remove banner at the top
let g:netrw_banner = 0
" netrw end

" fzf.vim
nnoremap <silent> <C-p> :Files<CR>
" fzf.vim end

" neoclide/coc.nvim
" TypeScript server for code completion
let g:coc_global_extensions = ['coc-tsserver']

" <leader>ca - Apply code action to the current line
nmap <leader>ca <Plug>(coc-codeaction)
" <leader>qf - Apply auto fix to the current line
nmap <leader>qf <Plug>(coc-fix-current)
" <leader>gd - Go to definition
nmap <leader>gd <Plug>(coc-definition)
" <leader>gt - Go to type
nmap <leader>gt <Plug>(coc-type-definition)
" <leader>gi - Go to implementation
nmap <leader>gi <Plug>(coc-implementation)
" <leader>gr - Go to references
nmap <leader>gr <Plug>(coc-references)
" neoclide/coc.nvim
