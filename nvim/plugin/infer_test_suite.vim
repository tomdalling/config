" try infer the test suite, so that :TestSuite works without opening a test
" file

if exists('g:test#last_position')
  finish
endif

let s:patterns = [
  \ { 'dir': 'test/automated', 'pattern': '*.rb'},
  \ { 'dir': 'spec', 'pattern': '*_spec.rb' },
  \ ]

for s:p in s:patterns
  " gets the path of the first file that matches the dir/pattern
  let s:path = trim(system('find '.shellescape(s:p.dir).' -iname '.shellescape(s:p.pattern).' -print -quit 2> /dev/null'))
  if s:path !=# ''
    let g:test#last_position = {
      \ 'file': s:path,
      \ 'col': 1,
      \ 'line': 1,
    \}
    " echom 'Detected test suite with: '.s:path
    finish
  endif
endfor

" echom 'Failed to detect test suite'
