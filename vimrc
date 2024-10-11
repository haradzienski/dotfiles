" Turn off VI compatibility
set nocompatible

" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " code competion
Plug 'editorconfig/editorconfig-vim'
Plug 'github/copilot.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Turn off regexp engine for syntax highlighting
set re=0
" vim-plug end

" Re-map <leader> to <Space>
nnoremap <Space> <Nop>
let mapleader = " "

" Display hybrid line numbers (relative and absolute)
set number relativenumber

" Show whitespace characters
" <leader>ws - Toggle whitespace characters
:set listchars=space:·,tab:>#,trail:·,eol:$
nnoremap <leader>ws :set list!<CR>

" netrw (the default file browser)
" remove banner at the top
let g:netrw_banner = 0
" netrw end

" fzf.vim
nnoremap <silent> <C-p> :Files<CR>
" fzf.vim end

" neoclide/coc.nvim
" CoC Extensions
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-prettier']

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=1000

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

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" <leader>cl - Run the Code Lens action on current line
nmap <leader>cl  <Plug>(coc-codelens-action)
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

" Set up Prettier command
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" <leader>p - Format file
" <leader>f - Format selection
nmap <leader>p :Prettier<cr>
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" neoclide/coc.nvim

