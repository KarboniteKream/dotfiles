setopt extendedglob
setopt histignorespace

export ZSH="$HOME/.oh-my-zsh"

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

source "$ZSH/oh-my-zsh.sh"
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source "$HOME/.cargo/env"

alias diff="colordiff"
alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"
alias gtfo="git stash push --include-untracked"
alias k="kubectl"
alias mutt="TERM=screen-256color mutt"
alias tt="taskwarrior-tui"

function garu {
    repository=$(basename "$(git remote get-url origin)")
    git remote add upstream "git@github.com:$1/$repository"
    git remote set-url upstream --push NO-PUSH
}

unalias gpr
function gpr {
    git checkout $(git_main_branch)
    git fetch upstream "pull/$1/head:PR-$1"
    git checkout "PR-$1"
}
