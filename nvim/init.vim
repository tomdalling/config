" TODO:
"  - vim-ruby
"  - dowl-dabooks
"  - utilisnips?
"  - CoC.vim for code completion?

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ajh17/VimCompletesMe' " trialing this as a replacement for supertab
Plug 'haya14busa/is.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'overcache/NeoSolarized'
Plug 'pbogut/fzf-mru.vim'
Plug 'plasticboy/vim-markdown'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-unimpaired'

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

" FZF settings
let g:fzf_preview_window='right:50%' "always show preview on right
let g:fzf_mru_relative = 1 "only show recent files from current dir
let g:fzf_mru_no_sort = 1 "always sort recent files by access date, not name

" make escape key in terminal
set ttimeoutlen=5

" markdown
let g:vim_markdown_frontmatter = 1 | " syntax highlight markdown YAML frontmatter
let g:vim_markdown_folding_disabled = 1 | " don't fold by default
let g:vim_markdown_conceal_code_blocks = 0 | " don't hide code fences (```)
let g:vim_markdown_autowrite = 1 | " save current file when following link
let g:vim_markdown_new_list_item_indent = 0 | " disable weird indenting behaviour
autocmd FileType markdown setlocal spelllang=en_au | " use en_au dictionary
autocmd FileType markdown setlocal complete+=kspell | " dictionary autocompletion
autocmd FileType markdown setlocal conceallevel=2 | " conceal markdown styling syntax
autocmd FileType markdown nmap <C-]> <Plug>Markdown_EditUrlUnderCursor | " open linked file

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
nnoremap gQ <nop>|" disable entering Ex mode (im hitting this accidentally)
nnoremap <expr> <Up> &wrap == 'wrap' ? 'k' : 'gk' |" arrows move on "visual" lines when wrapping is on
nnoremap <expr> <Down> &wrap == 'wrap' ? 'j' : 'gj' |" arrows move on "visual" lines when wrapping is on
nnoremap / /\v|" start search with 'very magic' turned on

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
nnoremap <leader>. :Files<cr>|" fuzzy file search
nnoremap <leader>m :FZFMru<cr>|" open file from list of previously opened

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
