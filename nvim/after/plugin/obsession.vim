augroup IncludeLastTestInSession
  autocmd!
  " this event fires after obession.vim overwrites a session file
  autocmd User Obsession call s:append_last_test(g:this_obsession)
augroup END

function! s:append_last_test(session_path) abort
  if !exists('g:test#last_position')
    return
  endif

  let l:line =  'let g:test#last_position = ' . string(g:test#last_position)
  call writefile([l:line], a:session_path, 'a')
endfunction
