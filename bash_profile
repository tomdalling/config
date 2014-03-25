# include bashrc
[[ -r ~/.bashrc ]] && source ~/.bashrc

# environment vars
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# aliases
alias ls='ls -lhF'
alias g='git'
alias r='rails'

# completions
_ssh_complete () {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local hosts="$(grep "^Host" ~/.ssh/config | awk '{print $2}' | xargs)"
    COMPREPLY=( $(compgen -W "$hosts" -- $cur) )
}
complete -F _ssh_complete ssh

# include .bash_profile.local if exists
[[ -r ~/.bash_profile.local ]] && source ~/.bash_profile.local
