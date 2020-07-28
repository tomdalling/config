setlocal nowrap
setlocal textwidth=80
setlocal linebreak

setlocal spell
setlocal spelllang=en_au
setlocal complete+=kspell | " dictionary autocompletion
setlocal conceallevel=2 | " conceal markdown styling syntax

nmap     <buffer> <C-]> <Plug>Markdown_EditUrlUnderCursor | " open linked file
nnoremap <buffer> <cr> {gq}$ge$|" return key autowraps paragraphs
