source "$HOME/.bashrc"

export PATH="$CONFIG_BASE/bin:$PATH"

# include .bash_profile.local if exists
source_if_exists "$HOME/.bash_profile.local"
