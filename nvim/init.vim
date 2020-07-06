" TODO:
"  - vim-test
"  - vim-ruby
"  - maybe is.vim or incsearch.vim
"  - dowl-dabooks
"  - utilisnips?
"  - CoC.vim for code completion?
"  - vim-markdown?

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ntpeters/vim-better-whitespace'
Plug 'overcache/NeoSolarized'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
" trialing this as a replacement for supertab
Plug 'ajh17/VimCompletesMe'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color scheme
set termguicolors
set background=dark
let g:neosolarized_contrast = "high"
colorscheme NeoSolarized
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

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

" start scrolling before cursor reaches top or bottom line
set scrolloff=10

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

" use 'smart case mode' in ripgrep
let g:rg_command = 'rg --vimgrep --smart-case'

" fix potential security issues by disabling modelines
set modelines=0
set nomodeline

" no hidden backup or swap files
set nobackup
set noswapfile

" keep undo history
set undofile
set undolevels=1000

" search options
set ignorecase " search is case insensitive if all lower case, but...
set smartcase " case sensitive search if search text contains any uppercase chars
set gdefault " apply substitutions globally by default (equivalent of "/g" on the end of regex)
set hlsearch " highlight all matches for the search (press space to get rid of the highlights)
set incsearch " highlight text as im typing
set inccommand=nosplit " show replacements while typing
" not using incsearch.vim atm. might use is.vim instead.
"let g:incsearch#auto_nohlsearch = 1 " auto run :nohlsearch
"let g:incsearch#magic = '\v' " PCRE-compitable regexes by default

" window sizing/splitting
set winwidth=100 " desired minimum width
set winminwidth=20
set winheight=30 " desired minimum height
set winminheight=7
set splitright
set splitbelow

" Enable mouse everywhere. Terminal won't scroll unless I do this, but it
" would be nice to restrict this to just the terminal.
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap U <c-r>|" redo
nnoremap Q @q|" play q macro
nnoremap <space> :nohlsearch<cr>|" remove search highlighting
nnoremap <S-Up> :wincmd k<cr>|" move between windows with shift + arrow keys
nnoremap <S-Down> :wincmd j<cr>|" move between windows with shift + arrow keys
nnoremap <S-Left> :wincmd h<cr>|" move between windows with shift + arrow keys
nnoremap <S-Right> :wincmd l<cr>|" move between windows with shift + arrow keys
nnoremap <c-]> g<c-]>|" better tag jumping

inoremap <up> <nop>|" disable arrow keys
inoremap <down> <nop>|" disable arrow keys
inoremap <left> <nop>|" disable arrow keys
inoremap <right> <nop>|" disable arrow keys

cnoremap %% <c-r>=expand('%:h').'/'<cr>|" directory of current file
cnoremap <C-A> <Home>|" ctrl-a jumps to start of command line

tnoremap <Esc> <C-\><C-n>|" escape exits terminal insert mode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do what i meant when i accidentally use capitals
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! E e


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader c-c-c-combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let maplocalleader = ","

nnoremap <leader><leader> <c-^>|" last edited file
nnoremap <leader>. :FZF!<cr>|" fuzzy file search
nnoremap <leader>m :call fzf#run(fzf#wrap({
  \ 'source': v:oldfiles,
  \ 'options': '--no-sort' }))<cr>|" open file from list of previously opened

nnoremap <leader>a :Rg<cr>|" search using word under cursor

nnoremap <leader>tt :TestLast<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ta :TestSuite<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autorun project-local .vimrc files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure
