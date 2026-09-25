setopt extendedglob
setopt histignorespace

export ZSH="$HOME/.oh-my-zsh"

ZSH_CUSTOM="$HOME/.zsh/omz"
ZSH_THEME="kream"
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  colored-man-pages
)

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.zsh/init.zsh"

source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source "$HOME/.cargo/env"

alias diff="colordiff"
alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"
alias gtfo="git stash push --include-untracked"
alias k="kubectl"
alias mutt="TERM=screen-256color mutt"
alias tt="taskwarrior-tui"
