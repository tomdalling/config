#!/bin/bash

set -euo pipefail

fail() {
    echo $1
    return 1
}

replace_with_sym() {
    name="$1"
    path="$2$1"

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

replace_with_sym bash_profile bash/
replace_with_sym bashrc bash/
replace_with_sym inputrc ''
replace_with_sym gitconfig git/
replace_with_sym irbrc ruby/
replace_with_sym gemrc ruby/
replace_with_sym pryrc ruby/
replace_with_sym byebugrc ruby/

echo "Done"
