augroup IncludeLastTestInSession
  autocmd!
  " this event fires after obession.vim overwrites a session file
  autocmd User Obsession call s:append_last_test(g:this_obsession)
augroup END

function! s:append_last_test(session_path) abort
  let l:globals_to_append = [
    \ 'test#last_position',
    \ 'test#last_command',
    \ 'test#last_strategy',
    \ ]

  let l:lines = []
  for l:global in l:globals_to_append
    if exists('g:' . l:global)
      call add(l:lines, 'let g:' . l:global . ' = ' . string(get(g:, l:global)))
    endif
  endfor

  call writefile(l:lines, a:session_path, 'a')
endfunction
