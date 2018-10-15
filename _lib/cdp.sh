cdp() {
    local NAME="$1"
    local PROJ_DIR=""

    if [[ -z "$NAME" ]] ; then
        PROJ_DIR="$HOME/proj"
    else
        PROJ_DIR="$(cdp_FindProjectDirectories "$NAME" | head -n 1)"
    fi

    if [[ ! -z "$PROJ_DIR" ]] ; then
        echo "cd $PROJ_DIR"
        cd "$PROJ_DIR"
    else
        echo "Project directory not found: $NAME"
    fi
}

cdp_FindProjectDirectories() {
    local NAME="$1"
    find -L ~/proj -depth 1 -maxdepth 1 -type d -iname "$NAME"
    #find -L ~/proj/_super -depth 1 -maxdepth 1 -type d -iname "$NAME"
}

cdp_AllProjectNames() {
    for PROJ_PATH in $(cdp_FindProjectDirectories "*") ; do
        basename "$PROJ_PATH"
    done
}

cdp_Complete () {
    local CUR=${COMP_WORDS[COMP_CWORD]}
    local PROJ_DIRS="$(cdp_AllProjectNames | xargs)"
    COMPREPLY=( $(compgen -W "$PROJ_DIRS" -- "$CUR") )
}
complete -o default -F cdp_Complete cdp
