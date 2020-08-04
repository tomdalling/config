setlocal nowrap
setlocal textwidth=80
setlocal linebreak

setlocal spell
setlocal spelllang=en_au
setlocal complete+=kspell | " dictionary autocompletion
setlocal conceallevel=2 | " conceal markdown styling syntax

" open linked file in split
nmap <buffer> <c-]> :vsp<cr><Plug>Markdown_EditUrlUnderCursor

" open linked file
nmap <buffer> gf <Plug>Markdown_EditUrlUnderCursor

" return key autowraps paragraph
nnoremap <buffer> <cr> vipgq$
