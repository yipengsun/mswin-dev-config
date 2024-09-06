function! custom#before() abort
    " you can defined mappings in bootstrap function
    " for example, use kj to exit insert mode.
    set spell
endfunction

function! custom#after() abort
    " you can remove key binding in bootstrap_after function
endfunction
