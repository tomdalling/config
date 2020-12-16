" TODO:
"  - dowl-dabooks
"  - utilisnips?
"  - CoC.vim for code completion?
let g:my_config_root = expand('<sfile>:p:h:h') " usually ~/config

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader keys (these need to be set before any mappings)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let maplocalleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'ajh17/VimCompletesMe' " trialing this as a replacement for supertab
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'slim-template/vim-slim'
Plug g:my_config_root.'/vim/bundle/dowl-dabooks'

Plug 'yssl/QFEnter'
  let g:qfenter_keymap = {}
  let g:qfenter_keymap.vopen = ['<C-v>']

Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_file_list_command = 'rg --files' " uses .gitignore and such
  let g:gutentags_cache_dir = g:my_config_root . '/nvim/gutentags/'
  " see: after/plugin/gutentags.vim

Plug 'tomdalling/vim-markdown-extras'
" Plug '~/proj/vim-markdown-extras'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
  let g:pandoc#syntax#conceal#urls = 1 " hide URL of links
  let g:pandoc#formatting#mode = "h" " use hard wraps
  " disable some default mappings (conflicts with vim-markdown-extras)
  let g:pandoc#keyboard#blacklist_submodule_mappings = ['links']

Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_operator='' " disable <leader>s mapping (I don't use it)

Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
  let g:lens#disabled_filetypes = ['fzf']
  let g:lens#height_resize_max = 30 " replaces 'winheight'
  let g:lens#height_resize_min = 7 " replaces 'winminheight'
  let g:lens#width_resize_max = 90 " replaces 'winwidth'
  let g:lens#width_resize_min = 20 " replaces 'winminwidth'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
  " (g)it (s)tatus -- Open :Git at the bottom, 13 rows high, jump to first file
  nmap <silent> <leader>gs :bot Git <bar> setlocal winfixheight <bar> resize 13 <bar> normal )<cr>
  " (g)it (S)TATUS -- Open :Git fullscreen
  nmap <silent> <leader>gS :tabedit <bar> Git <bar> only <bar> normal )<cr>
  " (g)it(h)ub (o)pen -- Open link to current line on GitHub
  nmap <leader>gho :.GBrowse<cr>
  " (g)it(h)ub (y)ank -- Copy link to current line/selection on GitHub
  nmap <leader>ghy :'<,'>GBrowse!<cr>

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0 | " define mappings myself
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)
  nmap <leader>ha :GitGutterQuickFix<cr>:copen<cr>:wincmd p<cr>:cfirst<cr>|" (h)unk (a)ll
  nmap <leader>hh <Plug>(GitGutterStageHunk)|" (h)unk add/stage
  nmap <leader>hc <Plug>(GitGutterUndoHunk)|" (h)unk (c)heckout -- undoes hunk changes
  nmap <leader>hp <Plug>(GitGutterPreviewHunk)|" (h)unk (p)review
  set updatetime=100 | " milliseconds before updating the gutter (also affects swap file writing)

Plug 'haya14busa/incsearch.vim'
  let g:incsearch#auto_nohlsearch = 1 " text movements do nohlsearch
  let g:incsearch#magic = '\v' " make all regexes 'very magic' by default
  let g:incsearch#consistent_n_direction = 1 " make n and N work the same for / and ?
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)zv|" zv because this ignores foldopen
  map N  <Plug>(incsearch-nohl-N)zv|" zv because this ignores foldopen
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_access_modifier_style = 'indent'
  let g:ruby_indent_assignment_style = 'variable'
  let g:ruby_indent_hanging_elements = 0
  " let ruby_fold = 1
  let ruby_foldable_groups = 'def class module << __END__'
  let ruby_spellcheck_strings = 1
  let ruby_space_errors = 1
  let ruby_operators = 1
  let ruby_pseudo_operators = 1
  let ruby_line_continuation_error = 1
  let ruby_global_variable_error = 1

Plug 'vim-test/vim-test'
  nnoremap <leader>tt :TestLast<cr>
  nnoremap <leader>tn :TestNearest<cr>
  nnoremap <leader>tf :TestFile<cr>
  nnoremap <leader>ta :TestSuite<cr>
  nnoremap <leader>tv :TestVisit<cr>
  let g:test#ruby#testbench#options = '--reverse-backtraces'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_preview_window='right:50%' "always show preview on right
  nnoremap <leader>. :Files<cr>|" fuzzy file search

Plug 'pbogut/fzf-mru.vim'
  let g:fzf_mru_relative = 1 "only show recent files from current dir
  let g:fzf_mru_no_sort = 1 "always sort recent files by access date, not name
  nnoremap <leader>m :FZFMru<cr>|" open file from list of previously opened

Plug 'jremmen/vim-ripgrep'
  let g:rg_command = 'rg --vimgrep --smart-case' | " use 'smart case mode' in ripgrep
  nnoremap <leader>a :Rg<cr>|" search using word under cursor

Plug 'overcache/NeoSolarized'
  let g:neosolarized_contrast = "high"

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'

Plug 'tpope/vim-eunuch'
  nnoremap <leader>fr :call feedkeys(":Rename " . expand('%:t'))<CR>|" (f)ile (r)ename
  nnoremap <leader>fm :call feedkeys(":Move " . expand('%'))<CR>|" (f)ile (m)ove
  nnoremap <leader>fd :Delete!<cr>|" (f)ile (d)elete
  nnoremap <leader>fw :Mkdir!<cr>:write<cr>|" (f)ile (w)rite - forces a write, creating directories if needed

Plug 'tpope/vim-abolish'
  " see: after/plugin/abolish.vim

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
  let g:prosession_dir = g:my_config_root . '/nvim/prosessions/'
  " see: plugin/after/obsession.vim
  let g:obsession_include_globals = [
    \ 'test#last_position',
    \ 'test#last_command',
    \ 'test#last_strategy',
    \ 'test#ruby#testbench#executable',
    \ ]

Plug 'AndrewRadev/splitjoin.vim'
  let g:splitjoin_trailing_comma = 1
  let g:splitjoin_ruby_curly_braces = 0
  let g:splitjoin_ruby_hanging_args = 0

Plug 'AndrewRadev/sideways.vim'
  nnoremap g<left> :SidewaysLeft<cr>
  nnoremap g<right> :SidewaysRight<cr>

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color scheme
set termguicolors
set background=dark
colorscheme NeoSolarized

" tabs are two spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" line wrapping
set nowrap
set textwidth=80 " hard wrap at 80 cols by default
set formatoptions-=t " DONT wrap text (i.e. code) by default
set formatoptions+=c " hard-wrap code comments
set formatoptions+=roj " recognise code comments when hard-wrapping
set formatoptions+=q " allow 'gq' to format comments
set formatoptions+=n2 " recognise list bullets when hard-wrapping

" use dumb auto-indenting
set autoindent

" start scrolling before cursor reaches edge of window
set scrolloff=10
set sidescrolloff=5

" visual aids
set showmode " show current mode (e.g. "-- INSERT --" or "-- VISUAL --")
set showcmd " show extra info along with mode (e.g. number of lines visually selected)
set cursorline " highligh line of text that cursor is currently in
set colorcolumn=+1 " vertical guide, one column after text width
set ruler " show current line number, column number
set number " show line numbers
set relativenumber " also show distances to other lines

" dont insert spaces when joining lines
set nojoinspaces

" fix potential security issues by disabling modelines
set modelines=0
set nomodeline

" no hidden backup or swap files
set nobackup
set noswapfile

" keep undo history
set undofile
set undolevels=1000

" automatically reload files modified outside of vim
" see: https://github.com/neovim/neovim/issues/2127
set autoread
augroup MyChecktime
  autocmd!
  if !has("gui_running")
    autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime
  endif
augroup END

" search options
set ignorecase " search is case insensitive if all lower case, but...
set smartcase " case sensitive search if search text contains any uppercase chars
set gdefault " apply substitutions globally by default (equivalent of "/g" on the end of regex)
set hlsearch " highlight all matches for the search (press space to get rid of the highlights)
set incsearch " highlight text as im typing
set inccommand=nosplit " show replacements while typing

" window splitting
set splitright
set splitbelow

" folding
set foldmethod=marker " no auto-folding by default, unless there are markers in the text itself
set foldlevelstart=2 " unfold two layers by default, when opening a file
set foldminlines=6 " don't fold small things
set foldopen=hor,insert,jump,mark,percent,quickfix,search,tag,undo " things that auto-open a fold

" tab completion in commands
set wildmode=longest:full,full

" auto-save file before certain commands, like <C-]> for tag jumping, which
" would otherwise fail due to the file having unsaved changes
set autowrite

" enable mouse (see mappings. scroll works, but buttons are disabled)
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup MyTerminal
  autocmd!
  " workaround for a segfault: https://github.com/neovim/neovim/issues/11548#issuecomment-583081783
  au TermOpen * setlocal wrap
  " immediately enter insert mode when switching to a terminal
  "au BufEnter term://* startinsert!
augroup END

set ttimeoutlen=5 | " make escape key work faster in terminal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MyCloseHelp() abort
  for l:buf in nvim_list_bufs()
    if getbufvar(l:buf, '&buftype', 'ERROR') ==# 'help' " only help buffers
      if bufwinnr(l:buf) != -1 " only active (visible) buffers
        exe 'bdelete' l:buf
      endif
    endif
  endfor
endfunction

function! MyAliasCommand(new_cmd, existing_cmd) abort
  exec 'cnoreabbrev <expr> '.a:new_cmd
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:new_cmd.'")'
        \ .'? ("'.a:existing_cmd.'") : ("'.a:new_cmd.'"))'
endfunction

function! MySystemPasteboardYank(type, delete_afterwards) abort
  " make selection
  if a:type ==# 'line'
    silent exec 'normal! `[V`]'
  elseif a:type ==# 'char'
    silent exec 'normal! `[v`]'
  else
    echom 'Unhandled movement type: ' . a:type
    return
  endif

  if a:delete_afterwards
    " delete into * register
    normal! "*d
  else
    " yank into * register
    normal! "*y
  end
endfunction

function! MySystemCutOpfunc(type) abort
  call MySystemPasteboardYank(a:type, 1)
endfunction

function! MySystemCopyOpfunc(type) abort
  call MySystemPasteboardYank(a:type, 0)
endfunction

function! MyEnterKey() abort
  if &buftype ==# 'terminal'
    " close terminals
    quit
  elseif foldlevel(line('.')) > 0
    " toggle current fold and move window to view it (if fold is found)
    normal! zazt
  else
    " default behaviour
    exe "normal! \<cr>"
  endif
endfunction

" uses the jump list to go back/forward to the next/previous file
function! MyLeap(forward) abort
  let l:current_bufnr = bufnr('%')
  let l:jump_offset = 0
  let [l:jumplist, l:current_idx] = getjumplist()
  " NOTE: l:current_idx can be past the end of l:jumplist
  let l:desired_idx = min([l:current_idx, len(l:jumplist)-1])

  while l:desired_idx > 0 && l:desired_idx < len(l:jumplist)
    if l:jumplist[l:desired_idx].bufnr != bufnr('%')
      let l:offset = abs(l:current_idx - l:desired_idx)
      let l:key = a:forward ? "\<c-i>" : "\<c-o>"
      exe "normal! " . l:offset . l:key
      return
    else
      let l:desired_idx += a:forward ? 1 : -1
    endif
  endwhile

  echom "No further files"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do what i meant when i accidentally use capitals
call MyAliasCommand("WQ", "wq")
call MyAliasCommand("Wq", "wq")
call MyAliasCommand("Xa", "xa")
call MyAliasCommand("W", "w")
call MyAliasCommand("Q", "q")
call MyAliasCommand("E", "e")
call MyAliasCommand("Vsp", "vsp")
call MyAliasCommand("av", "AV") | " vim-projectionist
call MyAliasCommand("va", "AV") | " vim-projectionist
call MyAliasCommand("VA", "AV") | " vim-projectionist
call MyAliasCommand("Va", "AV") | " vim-projectionist
call MyAliasCommand("a", "A") | " vim-projectionist


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" normal mode
nnoremap Y y$|" make y/Y behave like d/D
nnoremap U <c-r>|" redo
nnoremap <space> :nohlsearch<cr>|" remove search highlighting
nnoremap <S-Up> :wincmd k<cr>|" move between windows with shift + arrow keys
nnoremap <S-Down> :wincmd j<cr>|" move between windows with shift + arrow keys
nnoremap <S-Left> :wincmd h<cr>|" move between windows with shift + arrow keys
nnoremap <S-Right> :wincmd l<cr>|" move between windows with shift + arrow keys
nnoremap <c-]> g<c-]>|" better tag jumping
nnoremap gQ <nop>|" disable entering Ex mode (im hitting this accidentally)
nnoremap <expr> <Up> (&wrap == 'wrap' ? 'k' : 'gk') |" arrows move on "visual" lines when wrapping is on
nnoremap <expr> <Down> (&wrap == 'wrap' ? 'j' : 'gj') |" arrows move on "visual" lines when wrapping is on
nnoremap <silent> q<down> :cclose<cr>:call MyCloseHelp()<cr>|" close quickfix window and help windows
nnoremap q<up> :bot copen<cr>|" open quickfix window
nnoremap Q @q|" play q macro
nnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
nnoremap <RightMouse> <nop>|" disable the dang mouse buttons
nnoremap <silent> <cr> :call MyEnterKey()<cr>| " enter key does context-specific stuff

" these are mapped to <c-s-o> and <c-s-i> via iTerm2
nnoremap <F18> :call MyLeap(0)<cr>| " <c-o> back to previous file
nnoremap <F19> :call MyLeap(1)<cr>| " <c-i> forward to next file

" insert mode
inoremap <up> <nop>|" disable arrow keys
inoremap <down> <nop>|" disable arrow keys
inoremap <left> <nop>|" disable arrow keys
inoremap <right> <nop>|" disable arrow keys
inoremap <LeftMouse> <nop>|" disable the dang mouse buttons
inoremap <RightMouse> <nop>|" disable the dang mouse buttons

" visual mode
vnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
vnoremap <RightMouse> <nop>|" disable the dang mouse buttons

" command line mode
cnoremap %% <c-r>=expand('%:h').'/'<cr>|" directory of current file
cnoremap <C-A> <Home>|" ctrl-a jumps to start of command line
cnoremap <Left> <Space><BS><Left>|" left key moves cursor in wildmenu
cnoremap <Right> <Space><BS><Right>|" right key moves cursor in wildmenu

" terminal mode
tnoremap <S-Up> <C-\><C-n>:wincmd k<cr>|" move between windows with shift + arrow keys
tnoremap <S-Down> <C-\><C-n>:wincmd j<cr>|" move between windows with shift + arrow keys
tnoremap <S-Left> <C-\><C-n>:wincmd h<cr>|" move between windows with shift + arrow keys
tnoremap <S-Right> <C-\><C-n>:wincmd l<cr>|" move between windows with shift + arrow keys
tnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
tnoremap <RightMouse> <nop>|" disable the dang mouse buttons

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global leader combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" normal mode
nnoremap <leader><leader> <c-^>|" last edited file
nnoremap <leader>s 1z=|" correct word to the most-likely spellcheck alternative

nnoremap <silent> <leader>c :set opfunc=MySystemCopyOpfunc<CR>g@|" copy to system clipboard (with movement)
nnoremap <silent> <leader>y :set opfunc=MySystemCopyOpfunc<CR>g@|" yank (copy) to system clipboard (with movement)
nnoremap <silent> <leader>x :set opfunc=MySystemCutOpfunc<CR>g@|" cut to system clipboard (with movement)
nnoremap <leader>p "*pv`]|" paste from system clipboard and select
nnoremap <leader>P "*Pv`]|" paste from system clipboard

nnoremap <leader>vs :source %<cr>|" (v)im (s)ource current file
nnoremap <leader>vv :exe 'vsplit' g:my_config_root.'/nvim/init.vim'<cr>|" (v)im edit (v)imrc
nnoremap <leader>vi :exe 'source' g:my_config_root.'/nvim/init.vim'<cr>:PlugInstall<cr>|" (v)imrc (i)nstall plugins

" visual mode
vnoremap <leader>c "*y|" copy to system pasteboard
vnoremap <leader>y "*y|" yank (copy) to system pasteboard
vnoremap <leader>x "*d|" cuts into system pasteboard
vnoremap <leader>v d"*p|" pastes over selection with system pasteboard

