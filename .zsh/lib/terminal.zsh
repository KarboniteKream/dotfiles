autoload -Uz add-zsh-hook

# Set the terminal tab and window titles.
function title() {
  if [[ "$TERM" == ("dumb"|"linux") ]]; then
    return 0
  fi

  setopt local_options
  setopt no_prompt_subst

  local tab_title="$1"
  local win_title="${2:-"$1"}"

  if [[ "$TERM" == ("screen"*|"tmux"*) ]]; then
    print -Pn "\e]2;${win_title:q}\e\\\ek${tab_title:q}\e\\"
  else
    print -Pn "\e]2;${win_title:q}\a\e]1;${tab_title:q}\a"
  fi
}

# Reset the title to the current directory.
function __terminal_title_precmd() {
  title "%2~" "%~"
}

# Update the title to the currently running command.
function __terminal_title_preexec() {
  emulate -L zsh
  setopt extended_glob

  local cmd="${1[(wr)^(*=*|sudo|ssh|-*)]:gs/%/%%}"
  local line="${2:gs/%/%%}"

  title "$cmd" "%100>...>${line}%<<"
}

# Report the current working directory to the terminal.
function __terminal_osc7_cwd() {
  # Skip remote SSH sessions and simple terminals.
  if [[ -n "$SSH_CLIENT$SSH_TTY" || "$TERM" == ("dumb"|"linux") ]]; then
    return 0
  fi

  print -rn -- $'\e]7;file://'"$HOST""${PWD// /%20}"$'\e\\'
}

add-zsh-hook precmd __terminal_title_precmd
add-zsh-hook preexec __terminal_title_preexec
add-zsh-hook precmd __terminal_osc7_cwd
