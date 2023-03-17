--
-- globals
--
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.my_config_root = vim.fn.expand('<sfile>:p:h:h') -- usually ~/config

--
-- plugins
--
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'neovim/nvim-lspconfig'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
  -- (g)it (b)lame -- Open `:Git blame %` in a new tab
  vim.keymap.set('n', '<leader>gb', ':tabnew % <bar> :Git blame<cr>')
  -- (g)it (l)og -- Show git commit history for current file
  vim.keymap.set('n', '<leader>gl', ':tabnew % <bar> :Git log --patch --follow -- % <bar> only <cr>')
  -- (g)it (S)TATUS -- Open :Git fullscreen
  vim.keymap.set('n', '<leader>gS', ':tabedit <bar> Git <bar> only <bar> normal )<cr>', {silent = true})
  -- (g)it (c)heckout -- Checks out current file from HEAD
  vim.keymap.set('n', '<leader>gc', ':Git checkout -- %<cr>:checktime<cr>', {silent = true})
  -- (g)it(h)ub open e(x)ternal -- Open link to current line/selection on GitHub
  vim.keymap.set('n', '<leader>ghx', ':.GBrowse<cr>')
  vim.keymap.set('x', '<leader>ghx', ":'<,'>GBrowse<cr>")
  -- (g)it(h)ub (l)ink -- Copy link to current line/selection on GitHub
  vim.keymap.set('n', '<leader>ghl', ':.GBrowse!<cr>')
  vim.keymap.set('x', '<leader>ghl', ":'<,'>GBrowse!<cr>")

Plug 'tpope/vim-eunuch'
  vim.keymap.set('n', '<leader>fr', ':call feedkeys(":Rename " . expand("%:t"))<CR>') -- (f)ile (r)ename
  vim.keymap.set('n', '<leader>fm', ':call feedkeys(":Move " . expand("%"))<CR>') -- (f)ile (m)ove
  vim.keymap.set('n', '<leader>fd', ':Delete!<cr>') -- (f)ile (d)elete
  vim.keymap.set('n', '<leader>fw', ':Mkdir!<cr>:write<cr>') -- (f)ile (w)rite - forces a write, creating directories if needed

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
  vim.g.prosession_dir = vim.g.my_config_root .. '/nvim/prosessions/'
  -- see: after/plugin/obsession.vim
  vim.g.obsession_include_globals = {
    'test#last_position',
    'test#last_command',
    'test#last_strategy',
    'test#ruby#testbench#executable',
  }

Plug 'tpope/vim-abolish'
  -- see: after/plugin/abolish.vim

Plug 'overcache/NeoSolarized'
  vim.g.neosolarized_contrast = "high"

Plug('junegunn/fzf', { ['do'] = function()
  vim.call('fzf#install')
end})
Plug 'junegunn/fzf.vim'
  vim.g.fzf_preview_window = 'right:50%' -- always show preview on right
  vim.keymap.set('n', '<leader>.', ':Files<cr>') -- fuzzy file search

Plug 'pbogut/fzf-mru.vim'
  vim.g.fzf_mru_relative = 1 -- only show recent files from current dir
  vim.g.fzf_mru_no_sort = 1 -- always sort recent files by access date, not name
  vim.keymap.set('n', '<leader>m', ':FZFMru<cr>') -- open file from list of previously opened

Plug 'jremmen/vim-ripgrep'
  vim.g.rg_command = 'rg --vimgrep --smart-case' -- use 'smart case mode' in ripgrep
  vim.cmd [[
    nnoremap <leader>a :call MyGlobalSearch(expand('<cword>'))<cr>|" search using word under cursor
    nnoremap <leader>A lB:call MyGlobalSearch(expand('<cWORD>'))<cr>|" search using FULL word under cursor
    vnoremap <leader>a y:call MyGlobalSearch(@")<cr>|" search using selected text
    function! MyGlobalSearch(text)
      let @/ = a:text
      exec "Rg -F " . shellescape(a:text)
      echo 'Search results for:' a:text
    endfunction
  ]]

Plug 'AndrewRadev/splitjoin.vim'
  vim.g.splitjoin_trailing_comma = 1
  vim.g.splitjoin_ruby_curly_braces = 0
  vim.g.splitjoin_ruby_hanging_args = 0

Plug 'AndrewRadev/sideways.vim'
  vim.keymap.set('n', 'g<left>', ':SidewaysLeft<cr>')
  vim.keymap.set('n', 'g<right>', ':SidewaysRight<cr>')

Plug 'vim-ruby/vim-ruby'
  vim.g.ruby_indent_access_modifier_style = 'indent'
  vim.g.ruby_indent_assignment_style = 'variable'
  vim.g.ruby_indent_hanging_elements = 0
  vim.cmd [[
    let ruby_foldable_groups = 'def class module << __END__'
    let ruby_spellcheck_strings = 1
    let ruby_space_errors = 1
    let ruby_operators = 1
    let ruby_pseudo_operators = 1
    let ruby_line_continuation_error = 1
    let ruby_global_variable_error = 1
  ]]

Plug 'vim-test/vim-test'
  vim.keymap.set('n', '<leader>tt', ':TestLast<cr>')
  vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>')
  vim.keymap.set('n', '<leader>tf', ':TestFile<cr>')
  vim.keymap.set('n', '<leader>ta', ':TestSuite<cr>')
  vim.keymap.set('n', '<leader>tv', ':TestVisit<cr>')

Plug 'airblade/vim-gitgutter'
  vim.g.gitgutter_map_keys = 0 -- define mappings myself
  vim.keymap.set('n', ']h', '<Plug>(GitGutterNextHunk)')
  vim.keymap.set('n', '[h', '<Plug>(GitGutterPrevHunk)')
  vim.keymap.set('n', '<leader>hc', '<Plug>(GitGutterUndoHunk)') --  (h)unk (c)heckout -- undoes hunk changes
  vim.keymap.set('n', '<leader>hp', '<Plug>(GitGutterPreviewHunk)') --  (h)unk (p)review
  vim.keymap.set('n', '<leader>hs', '<Plug>(GitGutterStageHunk)') --  (h)unk (s)tage
  vim.opt.updatetime = 100 -- milliseconds before updating the gutter (also affects swap file writing)

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'slim-template/vim-slim'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'

vim.call('plug#end')

--
-- options
--
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.autowriteall = true
vim.opt.background = 'dark'
vim.opt.backup = false
vim.opt.colorcolumn = '+1' -- vertical guide, one column after text width
vim.opt.cursorline = true -- highligh line of text that cursor is currently in
vim.opt.expandtab = true
vim.opt.formatoptions:append('c') -- hard-wrap code comments
vim.opt.formatoptions:append('n2') -- recognise list bullets when hard-wrapping
vim.opt.formatoptions:append('q') -- allow 'gq' to format comments
vim.opt.formatoptions:append('roj') -- recognise code comments when hard-wrapping
vim.opt.formatoptions:remove('t') -- DONT wrap text (i.e. code) by default
vim.opt.gdefault = true -- apply substitutions globally by default (equivalent of "/g" on the end of regex)
vim.opt.hlsearch = true -- highlight all matches for the search (press space to get rid of the highlights)
vim.opt.ignorecase = true -- search is case insensitive if all lower case, but...
vim.opt.inccommand = 'nosplit' -- show replacements while typing
vim.opt.incsearch = true -- highlight text as im typing
vim.opt.joinspaces = false
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.mouse = 'a' -- enable mouse (see mappings. scroll works, but buttons are disabled)
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- also show distances to other lines
vim.opt.ruler = true -- show current line number, column number
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.showcmd = true -- show extra info along with mode (e.g. number of lines visually selected)
vim.opt.showmode = true -- show current mode (e.g. "-- INSERT --" or "-- VISUAL --")
vim.opt.sidescrolloff = 5
vim.opt.smartcase = true -- case sensitive search if search text contains any uppercase chars
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.textwidth = 80 -- hard wrap at 80 cols by default
vim.opt.ttimeoutlen = 5 -- make escape key work faster in terminal
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.signcolumn = 'yes'

vim.cmd 'colorscheme NeoSolarized'

--
-- functions
--
vim.cmd [[
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

  function! MyCloseAuxilliaryWindows() abort
    cclose " close quickfix window

    for l:buf in nvim_list_bufs()
      let l:close = 0

      " help windows
      if getbufvar(l:buf, '&buftype', 'ERROR') ==# 'help'
        let l:close = 1
      endif

      " fugitive windows
      if getbufvar(l:buf, '&filetype', 'ERROR') ==# 'fugitive'
        let l:close = 1
      end

      " only active (visible) buffers
      if l:close && bufwinnr(l:buf) != -1
        exe 'bdelete' l:buf
      endif
    endfor
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
]]

--
-- misc crap
--
vim.cmd [[
  " automatically reload files modified outside of vim
  " see: https://github.com/neovim/neovim/issues/2127
  augroup MyChecktime
    autocmd!
    if !has("gui_running")
      autocmd BufEnter,FocusGained,WinEnter,VimResume * checktime
    endif
  augroup END
]]

-- load vimrc files (from within .git/ dirs, for added safety)
if vim.fn.filereadable('.git/vimrc') ~= 0 then
  vim.cmd [[ source .git/vimrc ]]
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'
cmp.setup({
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
  }, {
    {name = 'buffer'},
  }),
})

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

--
-- normal mode
--
vim.keymap.set('n', 'Y', 'y$') -- make y/Y behave like d/D
vim.keymap.set('n', 'Q', '@q') -- play q macro
vim.keymap.set('n', 'U', '<c-r>') -- redo
vim.keymap.set('n', '<s-up>', ':wincmd k<cr>') -- move between windows with shift + arrow keys
vim.keymap.set('n', '<s-down>', ':wincmd j<cr>') -- move between windows with shift + arrow keys
vim.keymap.set('n', '<s-left>', ':wincmd h<cr>') -- move between windows with shift + arrow keys
vim.keymap.set('n', '<s-right>', ':wincmd l<cr>') -- move between windows with shift + arrow keys
vim.keymap.set('n', '<leader><leader>', '<c-^>') -- last edited file
vim.keymap.set('n', '<space>', ':nohlsearch<cr>') -- remove search highlighting
vim.keymap.set('n', '<leader>p', '"*pv`]') -- paste from system clipboard and select
vim.keymap.set('n', '<leader>P', '"*Pv`]') -- paste from system clipboard
vim.keymap.set('n', 'q<up>', ':bot copen<cr>') -- open quickfix window
vim.keymap.set('n', ']d', vim.diagnostic.goto_next) -- jump to next diagnosic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev) -- jump to previous diagnosic
vim.keymap.set('n', 'qd', vim.diagnostic.setqflist)

vim.cmd [[
  nnoremap <silent> q<down> :call MyCloseAuxilliaryWindows()<cr>
  nnoremap <silent> <leader>c :set opfunc=MySystemCopyOpfunc<CR>g@|" copy to system clipboard (with movement)
  nnoremap <silent> <leader>y :set opfunc=MySystemCopyOpfunc<CR>g@|" yank (copy) to system clipboard (with movement)
  nnoremap <silent> <leader>x :set opfunc=MySystemCutOpfunc<CR>g@|" cut to system clipboard (with movement)
]]

--
-- visual mode
--
vim.keymap.set('v', '<Leader>c', '"*y') -- copy to system pasteboard
vim.keymap.set('v', '<Leader>x', '"*d') -- cuts into system pasteboard
vim.keymap.set('v', '<Leader>v', 'd"*p') -- pastes over selection with system pasteboard

--
-- insert mode
--
vim.keymap.set('i', '<up>', '<nop>') -- disable arrow keys
vim.keymap.set('i', '<down>', '<nop>') -- disable arrow keys
vim.keymap.set('i', '<left>', '<nop>') -- disable arrow keys
vim.keymap.set('i', '<right>', '<nop>') -- disable arrow keys
vim.keymap.set('i', '<LeftMouse>', '<nop>') -- disable the dang mouse buttons
vim.keymap.set('i', '<RightMouse>', '<nop>') -- disable the dang mouse buttons

--
-- command line mode
--
vim.keymap.set('c', '%%', "<c-r>=expand('%:h').'/'<cr>") -- directory of current file
--
-- TODO
--
      -- " normal mode
      -- nnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
      -- nnoremap <RightMouse> <nop>|" disable the dang mouse buttons
      -- nnoremap <silent> <cr> :call MyEnterKey()<cr>| " enter key does context-specific stuff

      -- " these are mapped to <c-s-o> and <c-s-i> via iTerm2
      -- nnoremap <F18> :call MyLeap(0)<cr>| " <c-o> back to previous file
      -- nnoremap <F19> :call MyLeap(1)<cr>| " <c-i> forward to next file


      -- " visual mode
      -- vnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
      -- vnoremap <RightMouse> <nop>|" disable the dang mouse buttons

      -- " command line mode
      -- cnoremap %% <c-r>=expand('%:h').'/'<cr>|" directory of current file
      -- cnoremap <C-A> <Home>|" ctrl-a jumps to start of command line
      -- cnoremap <Left> <Space><BS><Left>|" left key moves cursor in wildmenu
      -- cnoremap <Right> <Space><BS><Right>|" right key moves cursor in wildmenu

      -- " terminal mode
      -- tnoremap <S-Up> <C-\><C-n>:wincmd k<cr>|" move between windows with shift + arrow keys
      -- tnoremap <S-Down> <C-\><C-n>:wincmd j<cr>|" move between windows with shift + arrow keys
      -- tnoremap <S-Left> <C-\><C-n>:wincmd h<cr>|" move between windows with shift + arrow keys
      -- tnoremap <S-Right> <C-\><C-n>:wincmd l<cr>|" move between windows with shift + arrow keys
      -- tnoremap <LeftMouse> <nop>|" disable the dang mouse buttons
      -- tnoremap <RightMouse> <nop>|" disable the dang mouse buttons



--
-- command aliases
--
vim.cmd [[
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
]]
