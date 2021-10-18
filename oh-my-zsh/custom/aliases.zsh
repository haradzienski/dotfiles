# git
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gchp='git cherry-pick'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch --prune'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp='git pull --prune'
alias gpu='git push'
alias gr='git rebase'
alias gs='git status'
alias gus='git restore --staged' #aka git unstage

# kubectl
alias kcx='kubectl config use-context'

# npm
alias nix='npm i --save-exact'
alias nixd='npm i --save-exact --save-dev'
alias nixp='npm i --save-exact --save'

# brew
alias brew_install_deps='brew bundle --file="$HOME/.dotfiles/Brewfile" --no-upgrade'