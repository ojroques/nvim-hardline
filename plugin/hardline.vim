" nvim-hardline
" By Olivier Roques
" github.com/ojroques

if exists('g:loaded_hardline')
  finish
endif

lua require('hardline').autocommands()

let g:loaded_hardline = 1
