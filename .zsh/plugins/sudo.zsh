# Toggle 'sudo' for the current (or previous) command.
sudo-command-line() {
  # Get the previous command, if the buffer is empty.
  if [[ -z "$BUFFER" ]]; then
    BUFFER="$(fc -ln -1)"
  fi

  # Preserve leading whitespace.
  local whitespace="${BUFFER%%[![:space:]]*}"
  BUFFER="${BUFFER#$whitespace}"

  if [[ "$BUFFER" == "sudo "* ]]; then
    BUFFER="${BUFFER#sudo }"
  else
    BUFFER="sudo $BUFFER"
  fi

  BUFFER="${whitespace}${BUFFER}"
  CURSOR="${#BUFFER}"
}

zle -N sudo-command-line

# Bind to [Esc][Esc].
bindkey -M emacs "\e\e" sudo-command-line
bindkey -M vicmd "\e\e" sudo-command-line
bindkey -M viins "\e\e" sudo-command-line
