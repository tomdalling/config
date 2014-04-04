#!/bin/bash

set -e

fail() {
    echo $1
    return 1
}

replace_with_sym() {
    src="$1"
    dest="../.$src"

    # if it exists and it isn't a symlink
    if [[ -f "$dest" && ! -L "$dest" ]] ; then
        # append it with a ".local" extension
        cat "$dest" >> "$dest.local"
    fi 

    # remove it if it exists
    rm -f "$dest"

    #symlink to config file
    ln -s "config/$src" "$dest"
}

cd "$(dirname "$0")"
[[ "$(pwd)" == "$HOME/config" ]] || fail "Must be install in $HOME/config"

replace_with_sym bash_profile
replace_with_sym bashrc
replace_with_sym irbrc
replace_with_sym gitconfig
replace_with_sym gemrc
