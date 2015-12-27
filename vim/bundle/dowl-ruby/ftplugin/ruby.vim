if !exists("g:dowl_ruby_command")
    let g:dowl_ruby_command = "ruby"
endif

function! DowlRubyRun()
    silent !clear
    execute "!" . g:dowl_ruby_command . " " . bufname("%")
endfunction

function! DowlRubyEval(code)
    echom "Eval: " . a:code
    return system(g:dowl_ruby_command . ' -e "print eval(STDIN.read).inspect"', a:code)
endfunction

function! DowlRubyPasteCommented(text)
    let l:lines = split(a:text, '\n')
    let l:commented_lines = map(l:lines, '"# " . v:val')
    call append(line('.'), l:commented_lines)
endfunction

function! DowlRubyEvalLine()
    let l:result = DowlRubyEval(getline('.'))
    call DowlRubyPasteCommented(l:result)
endfunction

function! DowlRubyEvalSelection()
    let l:old_a = @a
    normal! `<"ay`>`>"Ayl

    let l:result = DowlRubyEval(@a)
    call DowlRubyPasteCommented(l:result)

    let @a = l:old_a
endfunction

nnoremap <buffer> <localleader>r :call DowlRubyRun()<cr>
nnoremap <buffer> <localleader>e :call DowlRubyEvalLine()<cr>
vnoremap <buffer> <localleader>e :<c-u>call DowlRubyEvalSelection()<cr>
