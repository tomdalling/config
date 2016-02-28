if exists("b:current_syntax")
    finish
endif

" see :help syn-match
syntax match dabooksComment "\v#.*$"
syntax match dabooksDate "\v^\d{4}-\d{2}-\d{2}"
syntax match dabooksAccount "\v^\s+[a-z_:/]+"
syntax match dabooksAmount "\v\$[0-9,.\-]+"
syntax match dabooksAmount "\v\$?_{2,}"

" see :help group-name
highlight link dabooksComment Comment
highlight link dabooksDate Statement
highlight link dabooksAccount Identifier
highlight link dabooksAmount Special

let b:current_syntax = "dabooks"
