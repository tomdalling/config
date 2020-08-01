" try infer the test suite, so that :TestSuite works without opening a test
" file
function! s:infer_test_suite() abort
  if !exists('g:test#last_position')
    let l:paths = []
    let l:paths = l:paths + glob('test/automated/**/*.rb', 1, 1)
    let l:paths = l:paths + glob('spec/**/*_spec.rb', 1, 1)

    if len(l:paths) > 0
      let g:test#last_position = {
        \ 'file': l:paths[0],
        \ 'col': 1,
        \ 'line': 1,
      \}
    endif
  endif
endfunction

call s:infer_test_suite()
