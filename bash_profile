CONFIG_BASE="$HOME/config"
source "$CONFIG_BASE/_lib/bash_common.sh"

# include bashrc
source_if_exists ~/.bashrc

# environment vars
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# aliases
alias ls='ls -lhF'
alias g='git'
alias r='rails'
mkcd() {
    mkdir -p "$1" && cd "$1"
}
mkpushd() {
    mkdir -p "$1" && pushd "$1"
}

# bash settings
set completion-ignore-case On

# completions
_ssh_complete () {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    if [[ $COMP_CWORD -eq 1 ]] ; then
        local hosts="$(grep "^Host" ~/.ssh/config | awk '{print $2}' | xargs)"
        COMPREPLY=( $(compgen -W "$hosts" -- $cur) )
    else
        COMPREPLY=()
    fi
}
complete -o default -F _ssh_complete ssh

# MacPorts Bash shell command completion
source_if_exists /opt/local/etc/profile.d/bash_completion.sh

# plugin-type things
source "$CONFIG_BASE/_lib/git_ps1.sh"

# include .bash_profile.local if exists
source_if_exists ~/.bash_profile.local

