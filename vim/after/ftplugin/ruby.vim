setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

nmap <leader>gs :call GoToSpec('vsplit')<CR>
nmap <leader>gS :call GoToSpec('edit')<CR>

function! GoToSpec(edit_command)
    let ext = expand('%:e')
    let root = expand('%:r')
    let spec_path = 'spec/' . l:root . '_spec.' . l:ext
    let spec_dir = fnamemodify(l:spec_path, ":h")
    silent execute '!mkdir -p' shellescape(l:spec_dir)
    execute a:edit_command l:spec_path
    redraw!
endfunction
