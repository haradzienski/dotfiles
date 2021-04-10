FZF_HOME=$(brew --prefix fzf)
FZF_BIN="${FZF_HOME}/bin"

# Add binary to PATH
# ------------------
if [[ ! "$PATH" == *${FZF_BIN}* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_BIN}"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${FZF_HOME}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${FZF_HOME}/shell/key-bindings.zsh"

# Settings
# --------
export FZF_COMPLETION_TRIGGER='~~'
