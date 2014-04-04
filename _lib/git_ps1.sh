source_if_exists /opt/local/share/git-core/git-prompt.sh
source_if_exists /etc/bash_completion.d/git
if command_exists __git_ps1 ; then
    export PS1='\[\033[01;32m\]\h\[\033[01;34m\] \W\[\033[31m\]$(__git_ps1 " (%s)") \[\033[01;34m\]$\[\033[00m\] '
fi
