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

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <leader>ca - Apply code action at the cursor position
nmap <leader>ca <Plug>(coc-codeaction-cursor)
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
" <leader>o - Outline (Go to symbol)
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" <leader>rn - Rename symbol
nmap <leader>rn <Plug>(coc-rename)
" <leader>re - Refactor
" <leader>r - Refactor selected
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" neoclide/coc.nvim
