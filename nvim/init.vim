" TODO:
"  - dowl-dabooks
"  - utilisnips?
"  - CoC.vim for code completion?

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader keys (these need to be set before any mappings)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let maplocalleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ajh17/VimCompletesMe' " trialing this as a replacement for supertab
Plug 'ntpeters/vim-better-whitespace'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

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
  let g:ruby_indent_inside_multiline_brackets_style = 'variable'
  let ruby_fold = 1
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

Plug 'plasticboy/vim-markdown'
  let g:vim_markdown_frontmatter = 1 | " syntax highlight markdown YAML frontmatter
  let g:vim_markdown_folding_disabled = 1 | " don't fold by default
  let g:vim_markdown_conceal_code_blocks = 0 | " don't hide code fences (```)
  let g:vim_markdown_autowrite = 1 | " save current file when following link
  let g:vim_markdown_new_list_item_indent = 0 | " disable weird indenting behaviour

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'

Plug 'wojtekmach/vim-rename'
  " (f)ile (r)ename
  nnoremap <leader>fr :call feedkeys(":Rename " . expand('%@'))<CR>
  " (f)ile (m)ove
  nnoremap <leader>fm :call feedkeys(":Rename " . expand('%@'))<CR>

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

" no line wrapping
set nowrap

" use dumb auto-indenting
set autoindent

" start scrolling before cursor reaches edge of window
set scrolloff=10
set sidescrolloff=5

" visual aids
set showmode " show current mode (e.g. "-- INSERT --" or "-- VISUAL --")
set showcmd " show extra info along with mode (e.g. number of lines visually selected)
set cursorline " highligh line of text that cursor is currently in
set colorcolumn=81 " vertical guide line after 80 chars
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

" window sizing/splitting
set winwidth=100 " desired minimum width
set winminwidth=20
set winheight=30 " desired minimum height
set winminheight=7
set splitright
set splitbelow

" folding
set foldmethod=manual " no auto-folding by default
set foldlevelstart=2 " unfold two layers by default, when opening a file
set foldminlines=6 " don't fold small things
set foldopen=hor,insert,jump,mark,percent,quickfix,search,tag,undo " things that auto-open a fold

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup MyTerminal
  autocmd!
  " immediately enter insert mode when switching to a terminal
  au BufEnter term://* startinsert!

  " Enable mouse in terminal. It won't scroll unless I do this.
  " `setlocal` doesn't actually work for `mouse` here, because it's a global
  " option, so `mouse` needs to be turned off again when exiting a terminal.
  au BufEnter term://* setlocal mouse=a
  au BufLeave term://* setlocal mouse=
augroup END

set ttimeoutlen=5 | " make escape key work faster in terminal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MyDeleteCurrentFile() abort
  let l:path = expand('%')
  let l:choice = confirm('Delete '.l:path.'?', "&Yes\n&No", 2)
  if l:choice == 1
    call delete(l:path)
    bdelete!
  endif
endfunction

function! MyAliasCommand(new_cmd, existing_cmd) abort
  exec 'cnoreabbrev <expr> '.a:new_cmd
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:new_cmd.'")'
        \ .'? ("'.a:existing_cmd.'") : ("'.a:new_cmd.'"))'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap U <c-r>|" redo
nnoremap Q @q|" play q macro
nnoremap <space> :nohlsearch<cr>|" remove search highlighting
nnoremap <cr> zazt|" toggle current fold and move window to view it
nnoremap <S-Up> :wincmd k<cr>|" move between windows with shift + arrow keys
nnoremap <S-Down> :wincmd j<cr>|" move between windows with shift + arrow keys
nnoremap <S-Left> :wincmd h<cr>|" move between windows with shift + arrow keys
nnoremap <S-Right> :wincmd l<cr>|" move between windows with shift + arrow keys
nnoremap <c-]> g<c-]>|" better tag jumping
nnoremap gQ <nop>|" disable entering Ex mode (im hitting this accidentally)
nnoremap <expr> <Up> &wrap == 'wrap' ? 'k' : 'gk' |" arrows move on "visual" lines when wrapping is on
nnoremap <expr> <Down> &wrap == 'wrap' ? 'j' : 'gj' |" arrows move on "visual" lines when wrapping is on

inoremap <up> <nop>|" disable arrow keys
inoremap <down> <nop>|" disable arrow keys
inoremap <left> <nop>|" disable arrow keys
inoremap <right> <nop>|" disable arrow keys

cnoremap %% <c-r>=expand('%:h').'/'<cr>|" directory of current file
cnoremap <C-A> <Home>|" ctrl-a jumps to start of command line

tnoremap <ScrollWheelUp> <C-\><C-n><ScrollWheelUp>|" scroll wheel exits terminal mode
tnoremap <ScrollWheelDown> <C-\><C-n><ScrollWheelDown>|" scroll wheel exits terminal mode
tnoremap <S-Up> <C-\><C-n>:wincmd k<cr>|" move between windows with shift + arrow keys
tnoremap <S-Down> <C-\><C-n>:wincmd j<cr>|" move between windows with shift + arrow keys
tnoremap <S-Left> <C-\><C-n>:wincmd h<cr>|" move between windows with shift + arrow keys
tnoremap <S-Right> <C-\><C-n>:wincmd l<cr>|" move between windows with shift + arrow keys

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do what i meant when i accidentally use capitals
call MyAliasCommand("WQ", "wq")
call MyAliasCommand("Wq", "wq")
call MyAliasCommand("W", "w")
call MyAliasCommand("Q", "q")
call MyAliasCommand("E", "e")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global leader combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader> <c-^>|" last edited file

nnoremap <leader>fd :call MyDeleteCurrentFile()<cr>|" f(ile) d(elete)
