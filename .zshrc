setopt extendedglob

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/.dotfiles/bin:/usr/local/sbin:$PATH"
export ZSH=~/.oh-my-zsh

ZSH_THEME=""
ZSH_CUSTOM=~/.zsh
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in ~/.oh-my-zsh/plugins and ~/.zsh/plugins.
plugins=(base16-shell colored-man-pages git sudo zsh-completions zsh-syntax-highlighting)

# Only update completions cache every 24 hours.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit && compdump
else
    compinit -C
fi

source $ZSH/oh-my-zsh.sh

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"

local ret_status="%(?:$:%{$fg_bold[red]%}$%{$reset_color%})"
PROMPT=$'%B%{$fg[green]%}%n@%m %{$fg[blue]%}%~%{$reset_color%}%b $(git_prompt_info)\n${ret_status} '
RPROMPT="%D{%H:%M:%S}"

alias diff="colordiff"
alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"

function mkcdir() {
	mkdir -p -- "$1" && cd -P -- "$1"
}
