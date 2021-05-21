" nvim-hardline
" By Olivier Roques
" github.com/ojroques

if exists('g:loaded_hardline')
  finish
endif

let g:loaded_hardline = 1

augroup hardline
  autocmd!
  autocmd WinClosed * lua require('hardline').clear_cache()
augroup END
