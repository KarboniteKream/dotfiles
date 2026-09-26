# Create and enter a directory.
function take() {
  mkdir -p "$1" && cd "$1"
}

# An 'open' command similar to macOS.
if [[ "$OSTYPE" != "darwin"* ]]; then
  function open() {
    nohup xdg-open "$@" &>/dev/null &!
  }
fi

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi
alias ll="ls -lh"
alias lla="ls -lha"

alias diff="diff --color=auto"
alias grep="grep --color=auto --exclude-dir={.git,.idea,.venv}"

alias dotfiles="git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME"
alias k="kubectl"
alias mutt="TERM=screen-256color mutt"
alias tt="taskwarrior-tui"
