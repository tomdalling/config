CONFIG_BASE="$HOME/config"
source "$CONFIG_BASE/_lib/bash_common.sh"
source "$CONFIG_BASE/_lib/cdp.sh"

# environment vars
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS="--color"
export PAGER="less -r" # -r allows ansi coloring

# bash settings
set completion-ignore-case On
stty -ixon # allows ctrl+s to pass through to vim
shopt -s histappend #append instead of replace history

# aliases
alias ls='ls -lhF'
alias g='git'
alias gs='git s'
alias r='rails'
alias ri='ri -f ansi'
alias be='bundle exec'

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

source_if_exists "$HOME/.bashrc.local"
