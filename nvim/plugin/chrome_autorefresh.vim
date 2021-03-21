" :ChromeAutorefreshEnable makes a buffer refresh Chrome whenever it is written
" :ChromeAutorefreshDisable stops it

if !exists('s:tab_to_refresh')
  let s:tab_to_refresh = 0
endif

function! s:enable() abort
  call s:remember_tab_to_refresh()

  augroup ChromeAutorefreshAugroup
    autocmd! * <buffer>
    au BufWritePost <buffer> call <sid>refresh()
  augroup END
endfunction

function! s:disable() abort
  let s:tab_to_refresh = 0

  augroup ChromeAutorefreshAugroup
    autocmd! * <buffer>
  augroup END
endfunction

function! s:refresh() abort
  if s:tab_to_refresh ==# 0
    echoerr "s:tab_to_refresh was 0"
    return
  endif

  let output = s:run_applescript([
    \ 'tell application "Chrome"',
    \ '  repeat with the_window in every window',
    \ '    set the_tab_index to 0',
    \ '    repeat with the_tab in every tab of the_window',
    \ '      set the_tab_index to the_tab_index + 1',
    \ '      if id of the_tab is equal to '.s:tab_to_refresh.' then',
    \ '        tell the_tab to reload',
    \ '        set active tab index of the_window to the_tab_index',
    \ '        set index of the_window to 1',
    \ '      end if',
    \ '    end repeat',
    \ '  end repeat',
    \ 'end tell',
    \ ])
  " echo output
endfunction

function! s:remember_tab_to_refresh() abort
  let s:tab_to_refresh = trim(s:run_applescript([
    \ 'tell application "Google Chrome"',
    \ '  get id of active tab of first window whose visible is true',
    \ 'end tell',
    \ ]))
  echo 'Will refresh Chrome tab '.s:tab_to_refresh.' on write'
endfunction

function! s:run_applescript(script) abort
  return system('osascript -', join(a:script, "\r"))
endfunction

command! ChromeAutorefreshDisable call <sid>disable()
command! ChromeAutorefreshEnable call <sid>enable()
