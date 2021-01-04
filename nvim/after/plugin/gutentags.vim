" Patches bug: https://github.com/ludovicchabant/vim-gutentags/issues/289
" Code adapted from: https://github.com/ludovicchabant/vim-gutentags/blob/8e69652c7a7e7aabd96cff21b6ee6b6a295c901c/autoload/gutentags/ctags.vim#L55-L63
function! MyGutentagsWorkaround() abort
  if !exists('b:gutentags_files') || !get(g:, 'gutentags_ctags_auto_set_tags', 1)
    return
  endif

  for tag_file_path in values(b:gutentags_files)
    if stridx(&tags, tag_file_path) == -1
      if has('win32') || has('win64')
        execute 'setlocal tags^=' . fnameescape(tag_file_path)
      else
        " spaces must be literally escaped in tags path
        let l:literal_space_escaped = substitute(fnameescape(tag_file_path), '\ ', '\\\\ ', 'g')
        execute 'setlocal tags^=' . l:literal_space_escaped
      endif
    endif
  endfor
endfunction

augroup MyGutentagsWorkaround
  autocmd!
  au FileType * call MyGutentagsWorkaround()
augroup END
