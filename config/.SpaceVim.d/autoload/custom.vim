function! custom#before() abort
  " enable spell check for selected filetypes
  autocmd FileType markdown,gitcommit,asciidoc setlocal spell
endfunction

function! custom#after() abort
  " you can remove key binding in bootstrap_after function
endfunction
