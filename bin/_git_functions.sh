function git_current_branch {
  git rev-parse --abbrev-ref HEAD
}

function git_working_directory_is_dirty {
  case "$(git status --porcelain)" in
  (*[![:space:]]*) return 0;; # dirty
  (*) return 1 # clean
  esac
}
