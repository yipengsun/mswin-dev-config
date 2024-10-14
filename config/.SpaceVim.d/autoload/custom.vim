function! custom#before() abort
  " enable spell check for selected filetypes
  autocmd FileType markdown,gitcommit,asciidoc setlocal spell

  " enable ctrl+c/ctrl+x in visual mode
  vnoremap <C-c> "+y
  vnoremap <C-x> "+x

  " enable ctrl+v in insert mode
  inoremap <C-v> <ESC>"+p
endfunction

function! custom#after() abort
  " you can remove key binding in bootstrap_after function
endfunction
