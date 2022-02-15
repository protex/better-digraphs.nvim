" If already loaded, we're done...
if exists("g:loaded_betterdigraphs")
    finish
endif
let loaded_betterdigraphs = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

command! Digraphs lua require'betterdigraphs'.digraphs()

" Restore previous external compatibility options
let &cpo = s:save_cpo
let g:loaded_betterdigraphs = 1
