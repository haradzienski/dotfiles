" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
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
