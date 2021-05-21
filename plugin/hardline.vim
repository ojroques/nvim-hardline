" nvim-hardline
" By Olivier Roques
" github.com/ojroques

if exists('g:loaded_hardline')
  finish
endif

let g:loaded_hardline = 1

function! ActiveLine()
  return luaeval('require("hardline").update_statusline(true)')
endfunction

function! InactiveLine()
  return luaeval('require("hardline").update_statusline(false)')
endfunction

augroup hardline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
  autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END
