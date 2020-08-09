if type brew &>/dev/null; then
  source_if_exists "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

__git_complete g _git
