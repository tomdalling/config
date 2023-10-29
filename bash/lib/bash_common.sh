command_exists() {
    hash $1 2>/dev/null
}

source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}
