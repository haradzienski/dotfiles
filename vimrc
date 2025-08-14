" Turn off VI compatibility
set nocompatible

" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " code competion
" Plug 'editorconfig/editorconfig-vim'
Plug 'github/copilot.vim' " GitHub Copilot
Plug 'sheerun/vim-polyglot' " syntax highlighting
Plug 'puremourning/vimspector' " debugger
Plug 'itchyny/lightline.vim' " status line
Plug 'dracula/vim', { 'as': 'dracula' } " dracula theme
Plug 'dense-analysis/ale'
call plug#end()

" Turn off regexp engine for syntax highlighting
set re=0
" vim-plug end

" Enable 24-bit colors
set termguicolors

" Set dracula colorscheme
colorscheme dracula

" Re-map <leader> to <Space>
nnoremap <Space> <Nop>
let mapleader = " "

" Display hybrid line numbers (relative and absolute)
set number relativenumber

" Show whitespace characters
" <leader>ws - Toggle whitespace characters
:set listchars=space:·,tab:>#,trail:·,eol:$
nnoremap <leader>ws :set list!<CR>

" Fold according to syntax
:set foldmethod=syntax

" Start with some folds open
set foldlevelstart=1

" Open new vertical splits on the right side
:set splitright

" Allow hidden buffers with unsaved changes
:set hidden

" netrw (the default file browser)
" remove banner at the top
let g:netrw_banner=0

" list things in tree mode
let g:netrw_liststyle=3
" netrw end

" fzf.vim
nnoremap <silent> <C-p> :Files<CR>
" fzf.vim end

" neoclide/coc.nvim
" CoC Extensions
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-git']

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

" puremourning/vimspector
" <leader>dd - Vimspector: Launch (debug debug)
nnoremap <leader>dd :call vimspector#Launch()<CR>
" <leader>de - Vimspector: Reset (debug end)
nnoremap <leader>de :call vimspector#Reset()<CR>
" <leader>dt - Vimspector: Toggle breakpoint (debug toggle)
nnoremap <leader>dt :call vimspector#ToggleBreakpoint()<CR>
" <leader>dc - Vimspector: Continue (debug continue)
nnoremap <leader>dc :call vimspector#Continue()<CR>
" <leader>di - Vimspector: Balloon (debug inspect)
" normal mode: word under cursor
nmap <leader>di <Plug>VimspectorBalloonEval
" visual mode: selected text 
xmap <leader>di <Plug>VimspectorBalloonEval
" <leader>dl - Vimspector: Step Over (debug l ->)
nnoremap <leader>dl <Plug>VimspectorStepOver
" <leader>dj - Vimspector: Step Into (debug j (arrow bottom))
nnoremap <leader>dj <Plug>VimspectorStepInto
" <leader>dk - Vimspector: Step Out (debug k ^)
nnoremap <leader>dk <Plug>VimspectorStepOut
" puremourning/vimspector end

" dense-analysis/ale
" Disable ALE in TypeScript
autocmd FileType typescript,typescriptreact let b:ale_enabled = 0

" Enable ALE globally, then selectively disable elsewhere (above)
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   'ruby': ['standardrb'],
\}
let g:ale_fix_on_save = 1

" Optional: Only lint on save or insert leave
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1

" Show ALE linting result in the status line
function! AleLinterStatus() abort
  let l:counts = ale#statusline#count(bufnr(''))

  let l:all_errors = l:counts.error + l:coutns.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \  '😔 %dW %dE',
        \  all_non_errors,
        \  all_errors,
        \)
endfunction

" dense-analysis/ale end

" itchyny/lightline.vim
set laststatus=2

" Stop echoing filename and line count into command line
:set shortmess+=F

" Mode is now shown in the status line
set noshowmode

" Show the current git branch in the status line
function! LightlineGitBranch() abort
  return get(g:, 'coc_git_status', '')
endfunction

" Show size of the current selection in the status line
function! LightlineVisualSelectionSize()
  if mode() ==# 'v' || mode() ==# 'V' || mode() ==# "\<C-v>"
    let l:lines = abs(line("v") - line(".")) + 1
    let l:cols = abs(col("v") - col(".")) + 1
    return l:lines . 'x' . l:cols
  endif
  return ''
endfunction

let g:lightline = {
\   'colorscheme': 'darcula',
\   'active': {
\     'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'gitbranch' ] ],
\     'right': [ [ 'lineinfo' ],
\                [ 'percent' ],
\                [ 'fileformat', 'fileencoding', 'filetype' ],
\                [ 'alelinterstatus' ],
\                [ 'visualselectionsize' ] ]
\   },
\   'component_function': {
\     'gitbranch': 'LightlineGitBranch',
\     'visualselectionsize': 'LightlineVisualSelectionSize',
\     'alelinterstatus': 'AleLinterStatus'
\   },
\ }
" itchyny/lightline.vim end