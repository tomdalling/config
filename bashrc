CONFIG_BASE="$HOME/config"
source "$CONFIG_BASE/_lib/bash_common.sh"
source "$CONFIG_BASE/_lib/chruby.sh"

# environment vars
export EDITOR='nvim'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS="--color"
export PAGER="less -r" # -r allows ansi coloring
export XDG_CONFIG_HOME="$CONFIG_BASE"
export FZF_DEFAULT_COMMAND="rg --files" # respects .gitignore

# bash settings
set completion-ignore-case On
stty -ixon # allows ctrl+s to pass through to vim
shopt -s histappend # append instead of replace history
shopt -s cmdhist # one line per command in history
export HISTFILESIZE=1000000 # bigger history file
export HISTSIZE=1000000 # bigger history file
export HISTCONTROL=ignoreboth # ignore duplicate commands, and commands starting with a space
export HISTIGNORE='ls:bg:fg:history' # do not store these commands in history
export PROMPT_COMMAND='history -a' # save history immediately (don't wait for shell exit)
export CDPATH=".:~:~/proj:/Volumes" # easy `cd`ing into common directories

# aliases
alias ls='ls -lhF'
alias g='git'
alias gs='git s'
alias r='rails'
alias ri='ri -f ansi'
alias be='bundle exec'
if [ -x "$(command -v nvim)" ]; then
  alias vim='nvim'
fi
alias cdm='memex mount && cd /Volumes/Memex'
alias journal='memex run journal'
alias zettel='memex run zettel'
alias wiki='memex run wiki'
alias vimrc='vim -O ~/config/nvim/init.vim'

# plugin-type things
source "$CONFIG_BASE/_lib/brew_bash_completion.sh"
source "$CONFIG_BASE/_lib/git_ps1.sh"

source_if_exists "$HOME/.bashrc.local"
source_if_exists "$HOME/.fzf.bash" # fzf dumps config here on install
