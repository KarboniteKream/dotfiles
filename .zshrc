setopt extendedglob
setopt histignorespace

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.dotfiles/bin:/usr/local/sbin:$PATH"
export EDITOR="vim"

export ZSH="$HOME/.oh-my-zsh"

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

ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="kream"
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    # $ZSH/plugins
    colored-man-pages
    git
    sudo

    # $ZSH_CUSTOM/plugins
    base16-shell
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source /usr/local/opt/fzf/shell/key-bindings.zsh

alias diff="colordiff"
alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"
alias mutt="TERM=screen-256color mutt"
