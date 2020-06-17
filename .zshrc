setopt extendedglob
setopt histignorespace

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

_gen_fzf_default_opts() {
    local color00='#1b1918'
    local color01='#2c2421'
    local color02='#68615e'
    local color03='#766e6b'
    local color04='#9c9491'
    local color05='#a8a19f'
    local color06='#e6e2e0'
    local color07='#f1efee'
    local color08='#f22c40'
    local color09='#df5320'
    local color0A='#c38418'
    local color0B='#7b9726'
    local color0C='#3d97b8'
    local color0D='#407ee7'
    local color0E='#6666ea'
    local color0F='#c33ff3'

    export FZF_DEFAULT_OPTS="
      $FZF_DEFAULT_OPTS
      --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
      --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
      --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
    "
}

_gen_fzf_default_opts
