#!/bin/bash

set -euo pipefail

fail() {
    echo $1
    return 1
}

replace_with_sym() {
    path="$1"
    name="$(basename "$1")"

    dest="../.$name"

    echo "Installing ${name}..."

    # if it exists and it isn't a symlink
    if [[ -f "$dest" && ! -L "$dest" ]] ; then
        # append it with a ".local" extension
        cat "$dest" >> "$dest.local"
        echo "    Moved ~/.$name to ~/.${name}.local"
    fi

    # remove it if it exists
    rm -Rf "$dest"

    #symlink to config file
    ln -s "config/$path" "$dest"
}

cd "$(dirname "$0")"
[[ "$(pwd)" == "$HOME/config" ]] || fail "Must be installed in $HOME/config"

replace_with_sym bash/bash_profile
replace_with_sym bash/bashrc
replace_with_sym bash/inputrc
replace_with_sym git/gitconfig
replace_with_sym ruby/irbrc
replace_with_sym ruby/gemrc
replace_with_sym ruby/pryrc
replace_with_sym ruby/byebugrc 

echo "Installing stuff from Brewfile..."
brew bundle

echo "Done"
echo
echo "If this is a new machine, you probably want to install Neovim plugins now:"
echo "    nvim +'PlugInstall --sync'"
