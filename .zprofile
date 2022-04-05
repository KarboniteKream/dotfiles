export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.bin:$HOME/.cargo/bin:/opt/homebrew/sbin:$PATH"
export EDITOR="vim"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="
    --inline-info --height=16 --reverse
    --color=bg+:#2c2421,bg:#1b1918,spinner:#3d97b8,hl:#407ee7
    --color=fg:#9c9491,header:#407ee7,info:#c38418,pointer:#3d97b8
    --color=marker:#3d97b8,fg+:#e6e2e0,prompt:#c38418,hl+:#407ee7
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

eval "$(/opt/homebrew/bin/brew shellenv)"
