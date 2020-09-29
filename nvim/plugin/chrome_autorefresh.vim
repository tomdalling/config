" :ChromeAutorefreshEnable makes a buffer refresh Chrome whenever it is written
" :ChromeAutorefreshDisable stops it

function! s:enable() abort
  augroup ChromeAutorefreshAugroup
    autocmd! * <buffer>
    au BufWritePost <buffer> call <sid>refresh()
  augroup END
endfunction

function! s:disable() abort
  augroup ChromeAutorefreshAugroup
    autocmd! * <buffer>
  augroup END
endfunction

function! s:refresh() abort
  let script = [
    \ 'tell application "Chrome" to tell the active tab of its first window',
    \ '  reload',
    \ 'end tell',
    \ ]

  call system('osascript', join(script, "\r"))
endfunction

command! ChromeAutorefreshDisable call <sid>disable()
command! ChromeAutorefreshEnable call <sid>enable()
