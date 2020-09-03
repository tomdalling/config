augroup IncludeGlobalsInObsession
  autocmd!
  " this event fires after obession.vim overwrites a session file
  autocmd User Obsession call s:append_globals(g:this_obsession)
augroup END

function! s:append_globals(session_path) abort
  if !exists('g:obsession_include_globals')
    return
  endif

  let l:lines = []
  for l:global in g:obsession_include_globals
    if exists('g:' . l:global)
      call add(l:lines, 'let g:' . l:global . ' = ' . string(get(g:, l:global)))
    endif
  endfor

  call add(l:lines, 'windo normal! 0') " scroll to the left of every file

  call writefile(l:lines, a:session_path, 'a')
endfunction
