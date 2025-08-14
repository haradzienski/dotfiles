#!/bin/bash

# Snatched from github.com/MrPickles/dotfiles/configure.sh

# Configuration script to symlink the dotfiles or clean up the symlinks.
# The script supports three modes via -t: "work", "home", or "clean".
# - work: installs base Brewfile and optional Brewfile.work, then symlinks
# - home: installs base Brewfile only, then symlinks
# - clean: removes all symlinks

usage="Usage: $0 [-h] [-t <work|home|clean>]"

if [[ "$#" -lt 1 ]]; then
  echo "$usage"
  exit
fi

MODE=""

while getopts :ht: option; do
  case $option in
    h)
      echo "$usage"
      echo
      echo "OPTIONS"
      echo "-h            Output verbose usage message"
      echo "-t work       Install base Brewfile and Brewfile.work (if present), then set up dotfile symlinks and configure oh-my-zsh"
      echo "-t home       Install base Brewfile only, then set up dotfile symlinks and configure oh-my-zsh"
      echo "-t clean      Remove all existing dotfiles symlinks"
      exit;;
    t)
      case "$OPTARG" in
        work)
          MODE="work";;
        home)
          MODE="home";;
        clean)
          MODE="clean";;
        *)
          echo "$usage" >&2
          exit 1;;
      esac;;
    \?)
      echo "Unknown option: -$OPTARG" >&2
      exit 1;;
    :)
      echo "Missing argument for -$OPTARG" >&2
      exit 1;;
  esac
done

declare -a FILES_TO_SYMLINK=(
  'fzf.zsh'
  'gitconfig'
  'gitignore'
  'vimrc'
  'zshenv'
  'zshrc'
)

declare -a FULL_PATH_FILES_TO_SYMLINK=(
  'oh-my-zsh/custom/aliases.zsh'
  'oh-my-zsh/custom/functions.zsh'
  'vim/coc-settings.json'
)

print_success() {
  if [[ "$MODE" == "work" || "$MODE" == "home" ]]; then
    # Print output in green
    printf "\e[0;32m  [✔] %s\e[0m\n" "$1"
  else
    # Print output in cyan
    printf "\e[0;36m  [✔] Unlinked %s\e[0m\n" "$1"
  fi
}

print_error() {
  if [[ "$MODE" == "work" || "$MODE" == "home" ]]; then
    # Print output in red
    printf "\e[0;31m  [✖] %s %s\e[0m\n" "$1" "$2"
  else
    # Print output in red
    printf "\e[0;31m  [✖] Failed to unlink %s %s\e[0m\n" "$1" "$2"
  fi
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] %s\e[0m" "$1"
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

print_result() {
  if [ "$1" -eq 0 ]; then
    print_success "$2"
  else
    print_error "$2"
  fi

  [ "$3" == "true" ] && [ "$1" -ne 0 ] && exit
}

ask_for_confirmation() {
  print_question "$1 [y/N] "
  read -r -n 1
  printf "\n"
}

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

install_homebrew() {
  # Test to see if it is already installed
  if [ -z "$(command -v brew)" ]; then
    # Install if not
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_package() {
  local packageName=$1

  # Test to see if the package is installed
  if [ -z "$(command -v $packageName)" ]; then
    # Install if not
    brew install $packageName    
  fi
}

install_zsh() {
  install_package "zsh"

  # Set the default shell to zsh if it isn't currently set to zsh
  if [[ ! "$SHELL" == "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)"
  fi
  
  # Clone Oh My Zsh if it isn't already present
  if [[ ! -d $HOME/.oh-my-zsh/ ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  
  # Clone zsh-syntax-highlighting plugin if it isn't already present
  if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  fi

  # Clone zsh-nvm plugin if it isn't already present
  if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-nvm ]]; then
    git clone https://github.com/lukechilds/zsh-nvm "$HOME/.oh-my-zsh/custom/plugins/zsh-nvm"
  fi

  if [[ ! -d $HOME/.oh-my-zsh/completions/_docker ]]; then
    mkdir -p $HOME/.oh-my-zsh/completions
    docker completion zsh > $HOME/.oh-my-zsh/completions/_docker
  fi
}

install_vim_plug() {
  if [[ ! -d $HOME/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  
  vim -c 'PlugClean!' \
      -c 'PlugInstall' \
      -c 'VimspectorInstall vscode-js-debug' \
      -c 'VimspectorUpdate' \
      -c 'CocUpdateSync' \
      -c 'qa!'
}

link_file() {
  local sourceFile=$1
  local targetFile=$2

  if [ ! -e "$targetFile" ]; then
    execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
  elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
    print_success "$targetFile → $sourceFile"
  else
    ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
    if answer_is_yes; then
      rm -rf "$targetFile"
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    else
      print_error "$targetFile → $sourceFile"
    fi
  fi
}

unlink_file() {
  local sourceFile=$1
  local targetFile=$2

  if [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
    execute "unlink $targetFile" "$targetFile"
  fi
}

if [[ "$MODE" == "work" || "$MODE" == "home" ]]; then
  install_homebrew
  brew update
  brew bundle --file="$HOME/.dotfiles/Brewfile" --no-upgrade
  if [[ "$MODE" == "work" ]] && [[ -f "$HOME/.dotfiles/Brewfile.work" ]]; then
    brew bundle --file="$HOME/.dotfiles/Brewfile.work" --no-upgrade
  fi
  install_zsh
  install_vim_plug
fi

# Symlink (or unlink) the dotfiles.
for i in "${FILES_TO_SYMLINK[@]}"; do
  sourceFile="$(pwd)/$i"
  targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

  if [[ "$MODE" == "work" || "$MODE" == "home" ]]; then
    link_file $sourceFile $targetFile
  else
    unlink_file $sourceFile $targetFile
  fi
done

for i in "${FULL_PATH_FILES_TO_SYMLINK[@]}"; do
  sourceFile="$(pwd)/$i"
  targetFile="$HOME/.$i"

  if [[ "$MODE" == "work" || "$MODE" == "home" ]]; then
    mkdir -p $(dirname $targetFile)
    link_file $sourceFile $targetFile
  else
    unlink_file $sourceFile $targetFile
  fi
done
