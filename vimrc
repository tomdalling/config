execute pathogen#infect()
execute pathogen#helptags()
runtime! macros/matchit.vim "load matchit.vim directly out of vim itself

" magic
set nocompatible

" leader is comma
let mapleader = ","
let maplocalleader = ","

" syntax highlighting on
syntax on
filetype plugin on

" solarized theme + larger font on MacVim
if has("gui_macvim") || $TERM_PROGRAM == "iTerm.app"
    set background=dark
    colorscheme solarized
    set guifont=Menlo\ Regular:h15
endif

" nicer rainbow paren colors for solarized
let g:rbpt_colorpairs = [
  \ [ '4',  '#268bd2'],
  \ [ '6',  '#2aa198'],
  \ [ '2',  '#859900'],
  \ [ '3',  '#b58900'],
  \ [ '9',  '#cb4b16'],
  \ [ '1',  '#dc322f'],
  \ [ '5',  '#d33682'],
  \ [ '13', '#6c71c4'],
  \ ]

" Enable rainbow parentheses for all buffers
augroup rainbow_parentheses
  au!
  au VimEnter * RainbowParenthesesActivate
  au BufEnter * RainbowParenthesesLoadRound
  au BufEnter * RainbowParenthesesLoadSquare
  au BufEnter * RainbowParenthesesLoadBraces
augroup END

" fix some security issues by disabling modelines
set modelines=0

" tabs are four spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" no line wrapping
set nowrap

" use dumb auto-indenting
set autoindent

" don't let cursor scroll completely to the top or bottom
set scrolloff=10

" visual aids
set showmode " show current mode (e.g. "-- INSERT --" or "-- VISUAL --")
set showcmd " show extra info along with mode (e.g. number of lines visually selected)
set cursorline " highligh line of text that cursor is currently in
set colorcolumn=81 " vertical guide line after 80 chars
set ruler " show current line number, column number
set number " show line numbers
set relativenumber " also show distances to other lines
set laststatus=2 " makes vim-ariline plugin appear

" sane backspacing behaviour
set backspace=indent,eol,start

" no hidden backup or swap files
set nobackup
set noswapfile

" keep undo history
set undofile
set undodir=$HOME/config/vim/undo/
set undolevels=1000

" search options
set ignorecase " search is case insensitive if all lower case, but...
set smartcase " case sensitive search if search text contains any uppercase chars
set gdefault " apply substitutions globally by default (equivalent of "/g" on the end of regex)
set hlsearch " highlight all matches for the search (press space to get rid of the highlights)
set wildignore=*.log
set incsearch " highlight text as im typing
let g:incsearch#auto_nohlsearch = 1 " auto run :nohlsearch
let g:incsearch#magic = '\v' " PCRE-compitable regexes by default

" sets
" - max remembered files to 20
" - do not save registers
" - do not remember hilighted search matches
" - remember file marks
set viminfo='20,<0,h,f1

" automatically reload files modified outside of vim
set autoread

" dont insert spaces when joining lines
set nojoinspaces

" window sizes
set winwidth=100 " desired minimum width
set winminwidth=20
set winheight=30 " desired minimum height
silent! set winminheight=7
set splitright
set splitbelow

" ctrlp
let g:ctrlp_use_caching = 0 " don't cache the file list
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'] " ignore everything in .gitignore

" set the name of the ctags file to search
set tags=.tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do what i meant when i accidentally used capitals
command! WQ wq
command! Wq wq
command! W w
command! Q q

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" replace default search mappings with incsearch plugin
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" necessary to make `g:incsearch#auto_nohlsearch` option work
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

nnoremap U <c-r>|" redo
nnoremap <silent> <c-s> :update<cr>|" save
nnoremap Q @q|" play q macro
nnoremap <PageDown> j0zz|" scroll down with cursor centered
nnoremap <PageUp> k0zz|" scroll up with cursor centered
nnoremap <space> :nohlsearch<cr>|" remove search highlighting

vnoremap <silent> <c-s> <c-c>:update<cr>|" save

inoremap <silent> <c-s> <c-o>:update<cr>|" save
inoremap <up> <nop>|" disable arrow keys
inoremap <down> <nop>|" disable arrow keys
inoremap <left> <nop>|" disable arrow keys
inoremap <right> <nop>|" disable arrow keys

cnoremap %% <c-r>=expand('%:h').'/'<cr>|" directory of current file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader c-c-c-combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><Up> :wincmd k<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Down> :wincmd j<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Left> :wincmd h<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Right> :wincmd l<cr>|" move between windows the leader and arrow keys

nnoremap <leader>. :CtrlP<cr>|" fuzzy file search
nnoremap <leader><leader> <c-^>|" last edited file
nnoremap <leader>m :CtrlPMRU<cr>|" open file from list of previously opened
nnoremap <leader>/ :CtrlPTag<cr>|" open file based on ctags

nnoremap <leader>tt :TestLast<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ta :TestSuite<cr>

nnoremap <leader>ct :!ctags --tag-relative --extra=+f -Rf.tags --exclude=.git<cr>
nnoremap <leader>gd g<c-]>|" [g]o to [d]efinition (with ctags)

" TODO: move all of these into ftplugin
" clojure
autocmd FileType clojure nmap <leader>cd   <Plug>FireplaceK|"           [c]lojure show [d]ocumentation
autocmd FileType clojure nmap <leader>cs   <Plug>FireplaceSource|"      [c]lojure show [s]ourcecode
autocmd FileType clojure nmap <leader>cgs  <Plug>FireplaceDsplit|"      [c]lojure [g]o to [s]ourcecode, in a new split
autocmd FileType clojure nmap <leader>cgS  <Plug>FireplaceDjump|"       [c]lojure [g]o to [S]ourcecode, in current buffer
autocmd FileType clojure nmap <leader>ceb  <Plug>FireplaceCountPrint|"  [c]lojure [e]valuate around [b]rackets (parens)
autocmd FileType clojure nmap <leader>cebb <Plug>FireplaceCountPrint|"   ^
autocmd FileType clojure nmap <leader>cebr <Plug>FireplaceCountFilter|" [c]lojure [e]valuate around [b]rackets (parens) and [r]eplace
autocmd FileType clojure nmap <leader>cet  <Plug>FireplacePrompt|"      [c]lojure [e]valuate [t]ext typed in at prompt
autocmd FileType clojure nmap <leader>cr   :Require!<cr>|"              [c]lojure [r]eload namespace in REPL

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autorun project-local .vimrc files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure
