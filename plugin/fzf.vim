" Location:     plugin/fzf.vim
" Maintainer:   Qianqiang Liu <qianqiangliu@hotmail.com>
" Version:      1.0

if exists('g:loaded_fzf') || &cp
  finish
endif
let g:loaded_fzf = 1

function! s:find_root() abort
  let result = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return substitute(result, '\n*$', '', 'g')
  endif

  return "."
endfunction

function! s:on_exit(...) abort
  let root = getcwd()
  let path = term_getline(b:term_buf, 1)

  silent! close

  let full_path = root.'/'.path
  if filereadable(full_path)
    while &buftype != ""
      execute 'wincmd w'
    endwhile
    execute 'edit '.full_path
  endif
endfunction

function! s:fzf_open(path) abort
  if !executable('fzf')
    echohl ErrorMsg
    echomsg "You need to install 'fzf' first"
    echohl None
    return
  endif

  keepalt bo 9 new

  let root = a:path != '' ? a:path : s:find_root()
  if root != '.'
    execute 'lcd '.root
  endif

  let options = {'term_name':'FZF','curwin':1,'exit_cb':'s:on_exit'}
  let b:term_buf = term_start('fzf', options)
endfunction

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>
