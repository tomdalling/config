setlocal nowrap
setlocal textwidth=70
setlocal formatoptions+=t " wrap text by default
setlocal formatoptions-=c " turn on auto-wrapping for all text (disable comments)

setlocal spell
setlocal spelllang=en_au
setlocal complete+=kspell | " dictionary autocompletion
setlocal conceallevel=2 | " conceal markdown styling syntax
