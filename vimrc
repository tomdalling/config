execute pathogen#infect()
execute pathogen#helptags()
runtime! macros/matchit.vim "load matchit.vim directly out of vim itself

" magic
set nocompatible

" leader is comma
let mapleader = ","

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

" visual aids
set showmode " show current mode (e.g. "-- INSERT --" or "-- VISUAL --")
set showcmd " show extra info along with mode (e.g. number of lines visually selected)
set cursorline " highligh line of text that cursor is currently in
set ruler " show current line number, column number
set number " show line numbers
set relativenumber " also show distances to other lines

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
" use PCRE regex syntax instead of whatever vim normally uses
set ignorecase " search is case insensitive if all lower case, but...
set smartcase " case sensitive search if search text contains any uppercase chars
set gdefault " apply substitutions globally by default (equivalent of "/g" on the end of regex)
set wildignore=*.log

" sets
" - max remembered files to 20
" - do not save registers
" - do not remember hilighted search matches
set viminfo='20,<0,h

" automatically reload files modified outside of vim
set autoread

" filetype associations
au BufRead,BufNewFile *.rabl,*.thor,*.cap,*.podspec,Podfile set filetype=ruby
au BufRead,BufNewFile *.md,*.markdown set filetype=markdown

" window sizes
set noequalalways eadirection=both " dont automatically make windows equal sizes
set winwidth=100 " desired minimum width
set winheight=7
set winminheight=7
set winheight=999 " desired minimum height
set splitright
set splitbelow

let g:ctrlp_use_caching = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do what i meant when i accidentally used capitals
command! WQ wq
command! Wq wq
command! W w
command! Q q

function! s:MyVimgrep(pattern)
    " remember where we started from in mark F
    update
    execute "normal! mF"

    let pattern = empty(a:pattern) ? expand("<cword>") : a:pattern
    if empty(pattern)
        echoerr "No word under cursor, and no pattern supplied"
    else
        noautocmd silent! execute "vimgrep +\\C" . pattern . "+j ./**/*"
        copen "open list of results
        wincmd k "go back up to original window searched from
        cc "go to first result
    endif
endfunction
command! -nargs=? Search call s:MyVimgrep(<q-args>)

function! MyGoNext()
    update
    if empty(getqflist())
        "ctags
        tnext
    else
        "quickfix
        cnext
    endif
endfunction

function! MyGoPrev()
    update
    if empty(getqflist())
        "ctags
        tprevious
    else
        "quickfix
        cprevious
    endif
endfunction

function! MyGoBack()
    update
    if empty(getqflist())
        "quicktags
        pop
    else
        "quickfix
        cclose
        call setqflist([])
        execute "normal! `F"
    endif
endfunction

function! MyRunTestFile(path)
    if a:path =~ '_spec\.rb$'
        execute '!clear && bundle exec rspec "' . a:path . '" | less'
        return 1
    else
        return 0
    endif
endfunction

function! MyRunTests()
    update
    let currentFile = expand('%')
    if MyRunTestFile(currentFile)
        let g:my_last_run_test_path = currentFile
    elseif exists('g:my_last_run_test_path')
        call MyRunTestFile(g:my_last_run_test_path)
    else
        echoerr "Don't know how to run test: " . currentFile
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap U <c-r>|" redo
nnoremap <silent> <c-s> :update<cr>|" save
nnoremap / /\v|" use PCRE regex syntax
nnoremap Q @q|" play q macro
nnoremap <PageDown> j0zz|" scroll down with cursor centered
nnoremap <PageUp> k0zz|" scroll up with cursor centered

vnoremap / /\v|" use PCRE regex syntax
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
nnoremap <leader>p ]pV`]|" paste, indent and visually select lines
nnoremap <leader>P [PV`]|" paste, indent and visually select lines
nnoremap <leader><Up> :wincmd k<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Down> :wincmd j<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Left> :wincmd h<cr>|" move between windows the leader and arrow keys
nnoremap <leader><Right> :wincmd l<cr>|" move between windows the leader and arrow keys
nnoremap <leader>. :CtrlP<cr>|" fuzzy file search
nnoremap <leader><leader> <c-^>|" last edited file
nnoremap <leader>m :CtrlPMRU<cr>|" open file from list of previously opened
nnoremap <leader>/ :CtrlPTag<cr>|" open file based on ctags
nnoremap <leader>d <c-]>|" ctags go to definition
nnoremap <leader>n :call MyGoNext()<cr>
nnoremap <leader>N :call MyGoPrev()<cr>
nnoremap <leader>b :call MyGoBack()<cr>
nnoremap <leader>tt :call MyRunTests()<cr>

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
