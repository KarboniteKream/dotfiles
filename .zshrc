setopt extendedglob

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.dotfiles/bin:/usr/local/sbin:$PATH"
export EDITOR="vim"

export ZSH="$HOME/.oh-my-zsh"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="--inline-info --height=16 --reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="kream"
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    # ~/.oh-my-zsh/plugins
    colored-man-pages
    git
    sudo

    # ~/.zsh/plugins
    base16-shell
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Only update completions cache every 24 hours.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit && compdump
else
    compinit -C
fi

source $ZSH/oh-my-zsh.sh
source /usr/local/opt/fzf/shell/key-bindings.zsh

alias diff="colordiff"
alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"

function mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}
