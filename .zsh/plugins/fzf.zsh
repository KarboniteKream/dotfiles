if ! __require_cmd "fzf" "fd" "tree"; then
  return 1
fi

export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_DEFAULT_OPTS="
  --inline-info --height=16 --reverse
  --color=bg+:#2c2421,bg:#1b1918,spinner:#3d97b8,hl:#407ee7
  --color=fg:#9c9491,header:#407ee7,info:#c38418,pointer:#3d97b8
  --color=marker:#3d97b8,fg+:#e6e2e0,prompt:#c38418,hl+:#407ee7
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

if [[ -f "/usr/share/fzf/shell/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/shell/key-bindings.zsh"
elif [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
else
  print -u2 "Unable to locate fzf key bindings."
  return 1
fi
