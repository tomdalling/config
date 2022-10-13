" TODO:
"  - utilisnips?
"  - CoC.vim for code completion?
let g:my_config_root = expand('<sfile>:p:h:h') " usually ~/config

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'ajh17/VimCompletesMe' " trialing this as a replacement for supertab
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'andymass/vim-matchup'
Plug 'slim-template/vim-slim'
Plug 'ngmy/vim-rubocop'
Plug g:my_config_root.'/vim/bundle/dowl-dabooks'

Plug 'neovim/nvim-lspconfig'

Plug 'yssl/QFEnter'
  let g:qfenter_keymap = {}
  let g:qfenter_keymap.vopen = ['<C-v>']

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

  " filetype detection doesn't work properly, so need to disable this with an
  " autocmd. See: https://github.com/ntpeters/vim-better-whitespace/issues/137
  augroup MyDisableBetterWhitespaceInFigutive
    autocmd!
    autocmd FileType fugitive DisableWhitespace
    autocmd FileType git DisableWhitespace
  augroup END

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0 | " define mappings myself
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)
  nmap <leader>ha :GitGutterQuickFix<cr>:copen<cr>:wincmd p<cr>:cfirst<cr>|" (h)unk (a)ll
  nmap <leader>hh <Plug>(GitGutterStageHunk)|" (h)unk add/stage
  nmap <leader>hc <Plug>(GitGutterUndoHunk)|" (h)unk (c)heckout -- undoes hunk changes
  nmap <leader>hp <Plug>(GitGutterPreviewHunk)|" (h)unk (p)review
  nmap <leader>hs <Plug>(GitGutterStageHunk)|" (h)unk (s)tage
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

Plug 'vim-test/vim-test'
  nnoremap <leader>tt :TestLast<cr>
  nnoremap <leader>tn :TestNearest<cr>
  nnoremap <leader>tf :TestFile<cr>
  nnoremap <leader>ta :TestSuite<cr>
  nnoremap <leader>tv :TestVisit<cr>
  let g:test#ruby#testbench#options = '--reverse-backtraces'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#branch#enabled = 0
  let g:airline_detect_spell=0
  let g:airline#extensions#wordcount#filetypes = ['markdown', 'pandoc']
  let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 79,
      \ 'b': 79,
      \ 'x': 108,
      \ 'y': 108,
      \ 'z': 65,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

Plug 'Olical/aniseed', { 'tag': 'v3.16.0' }
Plug 'bakpakin/fennel.vim'
  let g:aniseed#env = v:true " load Fennel code as if it were viml

call plug#end()

lua <<ENDLUA
  local on_attach = function (client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  end
  require'lspconfig'.solargraph.setup{
    on_attach = on_attach
  }
ENDLUA
