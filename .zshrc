export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ZSH=~/.oh-my-zsh

ZSH_THEME=""
ZSH_CUSTOM=~/.zsh
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(base16-shell colored-man-pages git sudo wd zsh-syntax-highlighting)
fpath=(/usr/local/share/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh

# TODO: Improve with custom function.
local git_branch='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"

PROMPT="%B%{$fg[green]%}%n@%m %{$fg[blue]%}%~%{$reset_color%}%b ${git_branch}
$ "
RPROMPT="%D{%H:%M:%S}"

test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias diff="colordiff"


export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

mkcdir ()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}
