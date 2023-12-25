set clipboard=unnamed
set matchpairs+=<:>
set cindent
set cinoptions=:0,l1,t0,g0,(0
set cursorline
set background=dark
set termguicolors
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

colorscheme gruvbox

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
