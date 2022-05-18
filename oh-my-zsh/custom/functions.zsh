goto() {
  # cancel if no arguments
  if [ -z "$1" ]; then
    echo "Usage: goto <project>"
    return 0
  fi

  local P_DIR="$REPOS_DIR/$1"

  if [ -d "$P_DIR" ]; then
    cd "$P_DIR"
  else
    echo "$P_DIR does not exist"
    return 0
  fi
}

init_functions_autocomplete() {
  local REPOS=""

  # find all dirs under $REPOS_DIR, get their names, and build a space-separated string to feed into complete
  for dir in $(find $REPOS_DIR -type d -print0 -maxdepth 1 -mindepth 1 | xargs -0 basename); do
    REPOS+="$dir "
  done

  complete -W $REPOS goto
}

init_functions_autocomplete
