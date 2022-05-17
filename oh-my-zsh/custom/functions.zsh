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

# TODO: this is erroring out with "find: illegal option -- t", but works if put in .zshrc

# REPOS=""

# # find all dirs under $REPOS_DIR, get their names, and build a space-separated string to feed into complete
# for dir ($(find $REPOS_DIR -type d -print0 -maxdepth 1 -mindepth 1 | xargs -0 basename)); do
#   REPOS+="$dir "
# done

# complete -W "$REPOS" goto
