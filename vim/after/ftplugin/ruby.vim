setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

nmap <leader>gs :call GoToSpec()<CR>

function! GoToSpec()
    let ext = expand('%:e')
    let root = expand('%:r')
    let spec_path = 'spec/' . l:root . '_spec.' . l:ext
    let spec_dir = fnamemodify(l:spec_path, ":h")
    silent execute '!mkdir -p' shellescape(l:spec_dir)
    execute 'edit' l:spec_path
    redraw!
endfunction
